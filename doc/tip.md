# Lưu ý:

mkdir -p: không báo lỗi nếu đã tồn tại, tạo ra các thư mục cha nếu chưa có.
killall -0(/1) haproxy: Kiểm tra sự tồn tại của haproxy trong các process đang chạy. Nếu có exit code = 0, ngược lại exit code =1, vrrp sẽ dựa trên exit code này để biết server đó có khả dụng hay không. 

# Virtual Router Redundancy Protocol

- Giao thức cho phép nhiều router cùng chia sẻ một IP ảo và các địa chỉ MAC, tăng tính sẵn sàng cho hệ thống, người dùng sẽ không bị gián đoạn dịch vụ khi có sự cố xảy xa ở 1 hoặc 1 vài router nào.
- Server đóng vai trò master sẽ nắm VIP & MAC, các router dự phòng sẽ lắng nghe các gói tin hello từ router đó, mặt định mỗi 3 giây cho active, & 10 giây cho dead. 
- VRRP dùng địa chỉ multicast là 0000.5E00.01xx trong đó xx là dạng hex của chỉ số nhóm của VRRP.

 Giao thức VRRP là một giao thức chuẩn thay thế cho HSRP, được định nghĩa trong RFC2338. VRRP thì rất giống với HSRP vì vậy ta chỉ cần học sự khác nhau giữa hai giao thức và sự khác nhau về chức năng. Phần này liệt kê một số sự khác nhau giữa HSRP và VRRP:
- VRRP tạo ra một gateway dự phòng từ một nhóm các router. Router active được gọI là master router, tất cả các router còn lạI đều trong trạng thái backup. Router master là router có độ ưu tiên cao nhất trong nhóm VRRP.
- Chỉ số nhóm của VRRP thay đổI từ 0 đến 255; độ ưu tiên của router thay đổI từ 1 cho đến 254 (254 là cao nhất, mặc định là 100).
- Địa chỉ MAC của router ảo sẽ có dạng 0000.5e00.01xx, trong đó xx là một số dạng thập lục phân chỉ ra số của nhóm.
- Các quảng bá của VRRP được gửI mỗI chu kỳ một giây. Các router backup có thể học các chu kỳ quảng bá từ router master.
- Mặc định, tất cả các VRRP router được cấu hình theo chế độ pre-empt. Nghĩa là nếu có router nào có độ ưu tiên cao hơn độ ưu tiên của router master thì router đó sẽ chiếm quyền. 
- VRRP không có cơ chế để theo dõi một cổng của router.
- VRRP dùng địa chỉ multicast 224.0.0.18, dùng giao thức IP 112. VRRP có trong router IOS phiên bản Cisco IOS Software Release 12.0(18)ST.

## VRRP Trong haproxy

The Virtual Router Redundancy Protocol (VRRP) is a network protocol that provides for automatic assignment of available Internet Protocol (IP) routers to participating hosts. This ensures the high availability of the services that rely on HAPEE for load-balancing.

### VRRP comprises two parts:

* A software installed on each node of a VRRP cluster. It computes a weight based on its configuration and local health check results.
* A network protocol used by each node of a VRRP cluster to exchange information about their status.
Understanding VRRP
In general, VRRP works as follows:

* The node that has the highest weight is the master. The other nodes are slaves.
* The master hosts the Virtual IP (VIP). It notifies the switches and the servers on the LAN through ARP packets.
* The master emits a heartbeat packet every second. This packet contains its weight and goes out on a multicast IP address (224.0.0.18).
* Each node can change its weight based on its configuration and health check results.

### Failover triggers
The following events can trigger a failover:

* The master node lowers its weight below one of the slave nodes due to a failed health check.
* A slave node is configured with a weight larger than the current master node.
* The master stops emitting its heartbeat packet.

## ARP Address Resolution Protocol
Giao thức phân giải địa chỉ (Address Resolution Protocol hay ARP) là một giao thức truyền thông được sử dụng để chuyển địa chỉ từ tầng mạng (Internet layer) sang tầng liên kết dữ liệu theo mô hình OSI. Đây là một chức năng quan trọng trong giao thức IP của mạng máy tính. ARP được định nghĩa trong RFC 826 vào năm 1982, [1] là một tiêu chuẩn Internet STD 37.

ARP được sử dụng để từ một địa chỉ mạng (ví dụ một địa chỉ IPv4) tìm ra địa chỉ vật lý như một địa chỉ Ethernet (địa chỉ MAC), hay còn có thể nói là phân giải địa chỉ IP sang địa chỉ máy. ARP đã được thực hiện với nhiều kết hợp của công nghệ mạng và tầng liên kết dữ liệu, như IPv4, Chaosnet,..

Trong mạng Ethernet và WLAN các gói IP không được gởi trực tiếp. Một gói IP được bỏ vào một khung Ethernet, rồi mới được gởi đi. Khung này có một địa chỉ gởi và địa chỉ đích. Các địa chỉ này là địa chỉ MAC của một card mạng. Một card mạng sẽ nhận các khung ethernet mà có địa chỉ đích là địa chỉ MAC của mình. Card này sẽ không lưu ý tới các khung khác. Giao thức ARP được dùng để kết nối giữ địa chỉ MAC và địa chỉ IP. Để làm việc hiệu quả nó có giữ một bảng ARP lưu trữ

##NAT Network Adress Translation 

NAT đã là một phần không thể thiếu khi triển khai mạng IP diện rộng do không gian địa chỉ IPv4 đã bắt đầu co hẹp. Về cơ bản, NAT cho phép một (hay nhiều) địa chỉ IP nội miền được ánh xạ với một (hay nhiều) địa chỉ IP ngoại miền. Điều này cho phép sử dụng dải địa chỉ IP riêng theo chuẩn RFC 1918 trên các mạng nội bộ trong khi chỉ sử dụng một hoặc một số ít các địa chỉ IP công cộng.

## NIC network interface controller
## Keepalived 
1. Keepalived chạy trên một cái active LVS rounter (Linux Virtual Server) cùng với 1 hay nhiều backup LVS routers khác. Cái server active gọi là MASTER 
Active LVS router có 2 vai trò như sau: 
* Cân bằng tải thông qua active real server .
* Kiểm tra tình trạng của services trên từng real server có trong nhóm (Cả master lẫn backup)
Master rounter sẽ gửi gói tin thông báo trạng thái active của nó cho các rounter backup trong group bằng giao thức VRRP đều đặn theo một chu kì thời gian nhất định, nếu active rounter ngừng gửi gói tin thông báo, một master mới sẽ được bầu.
2. Trong mô hình của bài toán, mỗi LVS sẽ có hai network interfaces, 1 cho public và 1 cho private network cho phép chúng phân luồng giữ hai mạng., Trong ví dụ này sử dụng NAT để  chuyển luồng dữ liệu giữ hai lớp mạng. 
3.  virtual_rounter_id: specify to which VRRP router id the instance belongs: Phân biệt giữ nhiều vrrp instance
4.  advert_int: specify the advertisement interval in seconds (set to 1) 
5. interface: specify the network interface for the instance to run on 


## Check_mk 
Check_MK uses Nagios core for theses tasks:

* Manage Check results
* Triggering of alarms
* Manage planned downtimes
* Test host availability
* Detect network failures

Nagios uses nrpe to connect to clients and performs checks. This means that some Nagios plugins have to sit on the client and return results from when they are called.

Check_MK needs both: client side monitoring agent and server side monitoring system. The server side monitoring system calls the agent of the host and passes the check results to the monitoring core (usually Nagios but there is also an new core just for Check_MK). What makes Check_MK different from other passive Checks (like NRPE) is that the results for all checks is send to the monitoring system in one package.

Check-mk sử dụng check-mk-agent để kết nối clients với server & check. Ở client sẽ có check-mk-agent service nằm chờ và return kết quả khi được gọi. tất cả kq sẽ được đóng lại thành một gói duy nhất rồi gửi về cho server check-mk. 

$? Là biến môi trường được sử dụng để  lưu trữ exit code của câu lệnh được thực thi trước đó 


git checkout branch : change working branch
git add .
git commit -m "message"
git push 
git push origin fromBranch1:toBranch2

git config credential.helper store
