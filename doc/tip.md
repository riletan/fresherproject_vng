#Lưu ý:

mkdir -p: không báo lỗi nếu đã tồn tại, tạo ra các thư mục cha nếu chưa có.
killall -0(/1) haproxy: Kiểm tra sự tồn tại của haproxy trong các process đang chạy. Nếu có exit code = 0, ngược lại exit code =1, vrrp sẽ dựa trên exit code này để biết server đó có khả dụng hay không. 

#Virtual Router Redundancy Protocol

Giao thức VRRP là một giao thức chuẩn thay thế cho HSRP, được định nghĩa trong RFC2338. VRRP thì rất giống với HSRP vì vậy ta chỉ cần học sự khác nhau giữa hai giao thức và sự khác nhau về chức năng. Phần này liệt kê một số sự khác nhau giữa HSRP và VRRP:

- VRRP tạo ra một gateway dự phòng từ một nhóm các router. Router active được gọI là master router, tất cả các router còn lạI đều trong trạng thái backup. Router master là router có độ ưu tiên cao nhất trong nhóm VRRP.
- Chỉ số nhóm của VRRP thay đổI từ 0 đến 255; độ ưu tiên của router thay đổI từ 1 cho đến 254 (254 là cao nhất, mặc định là 100).
- Địa chỉ MAC của router ảo sẽ có dạng 0000.5e00.01xx, trong đó xx là một số dạng thập lục phân chỉ ra số của nhóm.
- Các quảng bá của VRRP được gửI mỗI chu kỳ một giây. Các router backup có thể học các chu kỳ quảng bá từ router master.
- Mặc định, tất cả các VRRP router được cấu hình theo chế độ pre-empt. Nghĩa là nếu có router nào có độ ưu tiên cao hơn độ ưu tiên của router master thì router đó sẽ chiếm quyền. 
- VRRP không có cơ chế để theo dõi một cổng của router.
- VRRP dùng địa chỉ multicast 224.0.0.18, dùng giao thức IP 112. VRRP có trong router IOS phiên bản Cisco IOS Software Release 12.0(18)ST.