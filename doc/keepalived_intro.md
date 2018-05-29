# Keepalived High Availability
Tham khảo: cuongquach.com thegioimang.vn keepalived.org
## Keepalived là gì ? 

Keepalive là một service trên linux được phát triên bằng C, cung cấp khả năng high availability (HA - sẵn sàng cao) cho hệ thống và  Load Balancing (Cân bằng tải) đơn giản, tuy nhiên khả năng cân bằng tải của keepalived có hạn và không thể tùy biến linh hoạt nên người ta thường chỉ sử dụng tính năng HA IP Failover của keepalived kết hợp với các dịch vụ load balancing khác như Haproxy/ Nginx.

* Keepalived cung cấp các framework với hai chức năng chính là cân bằng tải cùng cơ chế health checking và HA - sẵn sàng cao với giao thức VRRP.
* Tính năng cân bằng tải sử dụng LVS (Linux Vitual Server) module kernel Linux.
* HA Keepalived: dựa trên giao thức VRRP đảm nhận khả năng chịu lỗi của cụm server (Failover) với VIP. Giúp kết nối giữ người dùng với service được liên tục, người dũng sẽ không nhận ra ngay cả khi có bất kì server nào bị lỗi.

## VRRP (Virtual Rounter Redunancy Protocol)
Giao thức cho phép các Router cùng tham gia một nhóm xây dựng một router ảo làm gateway cho các host nằm trên mạng LAN, thực hiện dự phòng gateway cho các host đầu cuối.  VRRP là giao thức quốc tế có thể chạy trên nhiều sản phẩm của nhiều nhà sản xuất khác nhau. VRRP được mô tả trong RFC – 3768 của IETF.
```
- Giao thức cho phép nhiều router cùng chia sẻ một IP ảo và các địa chỉ MAC, tăng tính sẵn sàng cho hệ thống, người dùng sẽ không bị gián đoạn dịch vụ khi có sự cố xảy xa ở 1 hoặc 1 vài router nào.
- VRRP tạo ra một gateway dự phòng từ một nhóm các router. Router active được gọI là master router, tất cả các router còn lạI đều trong trạng thái backup.
- Router master là router có độ ưu tiên cao nhất trong nhóm VRRP. Master sẽ giữ VIP và đảm nhiệm việc gửi các gói tin quảng bá đến các servers khác trong cụm bằng các gói ARP.
- Địa chỉ MAC của router ảo sẽ có dạng 0000.5e00.01xx, trong đó xx là một số dạng thập lục phân chỉ ra số của nhóm
- Các gói tin quảng bá của VRRP được gửI mỗI chu kỳ một giây. Các router backup có thể học các chu kỳ quảng bá từ router master.
- Mặc định, tất cả các VRRP router được cấu hình theo chế độ pre-empt. Nghĩa là nếu có router nào có độ ưu tiên cao hơn độ ưu tiên của router master thì router đó sẽ chiếm quyền.
- Chỉ số nhóm của VRRP thay đổI từ 0 đến 255; độ ưu tiên của router thay đổI từ 1 cho đến 254 (254 là cao nhất, mặc định là 100).
- VRRP dùng địa chỉ multicast 224.0.0.18, dùng giao thức IP 112. VRRP có trong router IOS phiên bản Cisco IOS Software Release 12.0(18)ST.
- VRRP không có cơ chế để theo dõi một cổng của router.

```

## Cơ chế Keepalived Failover IP: Chuyển ngữ cảnh
Keepalived sẽ gom các server tham gia cụm HA, khở tạo một LVS đại diện cho nhóm với một VIP & địa chỉ mac của server đang nắm VIP đó. Trong một thời gian nhất định, chỉ có 1 server sử dụng địa chỉ MAC này tương ứng với VIP. Khi có request gửi tới VIP thì sevice sẽ trả về địa chỉ MAC này.

Các máy chủ dịch vụ sử dụng chung VIP phải liên lạc với nhau bằng địa chỉ multicast 224.0.0.18 qua giao thứ VRRP. Các server có độ ưu tiên từ 1-254 , server nào có độ cao nhất là master, các server còn lại là backup, hoạt động ở chế độ chờ.
![alt text](/doc/figure/keepalived_view.png)

Khi khởi động service toàn bộ các server cấu hình chung VIP sẽ gia nhập vào một nhóm multicast. Nhóm multicast này dùng để gửi nhận các gói tin quảng bá VRRP. Các server sẽ quảng bá độ ưu tiên của mình, sv có độ uư tiên cao nhất sẽ được bầu làm Master. Khi đã có master thì server master sẽ phải chịu tránh nhiệm gửi cái gói tin quảng bá định kì cho nhóm multicast.

Nếu vì một sự cố nào đó mà các server Backup trong nhóm không nhận được các gói tin quảng bá từ Master trong một khoảng thời gian nhất định thì cả nhóm sẽ bầu ra một Master mới. Server này sẽ tiếp quản VIP và gửi các gói tin quảng bá là nó đang giữ VIP này. Khi Master cũ trở lại hoạt động bình thường thì server này có thể trở thành Master hoặc Backup tùy theo cấu hình độ ưu tiên của các server khác trong nhóm. 
### Failover Triggers 
* Master node có trọng số thấp hơn các backup node khác do health check failed 
* Một Backup node có configuration với trọng số cao hơn Master node.
* Master node ngưng gửi đi các gói tin quảng bá.

## Các Linux kernel Keepalived sử dụng
Keepalived sử dụng 4 module chính:
* LVS Framework: dùng để giao tiếp sockets
* Netfilter Frameword: hỗi trợ hoạt động IP Vitual Server NAT.
* Netlink Interface: điều khiển thêm/xóa VRRP VIP trên card mạng.
* Multicast: VRRP advertisement packet được gửi tới địa chỉ broadcast (224.0.0.18)

Khi Keepalived chạy sẽ tạo ra 3 process cơ bản  gồm: 
* Một process cha gọi là "watchdog" sản sinh ra hai process con kế tiếp, quản lý và theo dõi các process con. Whatdog sẽ giao tiếp với các tiến trình con thông qua unix domain socket.
* Hai process con, 1 chịu trách nhiệm cho _VRRP_ và 1 chịu tránh nhiệm _health checking_.
## Kiến túc tổng quát 

![alt text](/doc/figure/keepalived.png)
