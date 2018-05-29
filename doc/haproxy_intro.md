# Haproxy Load balancing 
Tham khảo: dinhnn.com haproxy.org

HAProxy, viết tắt của High Availability Proxy, là phần mềm cân bằng tải TCP/HTP và giải pháp proxy mã nguồn mở phổ biến, có thể chạy trên Linux, Solaris, và FreeBSD. Nó thường dùng để cải thiện hiệu suất (performance) và sự tin cậy (reliability) của môi trường máy chủ bằng cách phân tán lưu lượng tải (workload) trên nhiều máy chủ (như web, application, database).
## References
### ACL (Acess Control List)
Trong mối liên hệ với việc cân bằng tải, ACLs thường dùng để test một số điều kiện và thực hiện 1 hành động (như chọn 1 máy chủ hoặc khóa 1 request) dựa trên kết quả test. Dùng ACLs cho phép chuyển hướng lưu lượng mạng một cách linh động dựa trên nhiều tác nhân giống pattern-matching và 1 số kết nối đến backend, ví dụ:
```
acl url_blog path_beg /blog
```
ACL này thỏa nếu đường dẫn trong request của người dùng bắt đầu với /blog. Ví dụ http://domain.com/blog/blog-entry-1.

### Backend
Backend là tập các máy chủ mà nhận các request được chuyển hướng. Backend được định nghĩa trong phần backend của cấu hình HAProxy. Cơ bản, 1 backend có thể được định nghĩa bởi:
* thuật toán cân bằng tải nào được dùng
* danh sách các máy chủ và cổng (port)

Một backend có thể chứa 1 hay nhiều máy chủ trong nó, thêm nhiều máy chủ vào backend sẽ gia tăng khả năng tải bằng cách phân phối lượng tải trên nhiều máy chủ. Gia tăng độ tin cậy cũng đạt được trong trường hợp này nếu một trong số các máy chủ của backend bị lỗi.

Ví dụ: 
```
backend app
   balance roundrobin
   server app1 10.0.2.4:80 check
   server app2 10.0.2.9:80 check
```
Backend trên bao gồm 2 web server, cân bằng tải theo thuật toán rr, tùy chọn _check_ ở cuối của mỗi server chỉ ra rằng việc health check sẽ được thực hiện trên các máy chủ backend.

### Front end 
Một frontend định nghĩa cách thức các request sẽ được chuyển hướng đến backend. Frontend được định nghĩa trong phần frontend của cấu hình HAProxy. Định nghĩa gồm các thành phần sau:
* Tập các địa chỉ IP và cổng (port) (vd: 10.1.1.7:80, *:443, …)
* ACLs
* Các quy tắc use_backend, mà định nghĩa backend nào sẽ được dùng phụ thuộc điều kiện ACL có khớp hay không, và/hoặc 1 quy tắt default_backend xử lý các trường hợp còn lại.
Một frontend có thể được cấu hình cho nhiều loại lưu lượng mạng.

## Các loại cân bằng tải 
1. Không cân bằng tải:

![alt text](/doc/figure/haproxy1.png)

Người dùng kết nối trực tiếp đến ứng dụng web, tại yourdomain.com và không có cơ chế cân bằng tải. Nếu máy chủ web (duy nhất) bị lỗi, người dùng sẽ không thể truy xuất đến web. Ngoài ra, nếu nhiều người dùng cùng truy xuất đến máy chủ web đồng thời và nó sẽ không thể xử lý kịp lượng tải gây ra chậm hoặc người dùng không thể kết nối đến web.

2. Cân bằng tải layer 4:
Cách đơn giản nhất để cân bằng lưu lượng mạng đến nhiều máy chủ là dùng cân bằng tải layer 4 (transport/network lalyer). Cân bằng tải theo cách này sẽ chuyển hướng lưu lượng người dùng dựa trên IP range và port, load balancer không đọc nội dung của các gói tin.

![alt text](/doc/figure/haproxy2.png)

Người dùng truy xuất load balancer, nó sẽ chuyển hướng request đến các máy chủ của web-backend. Máy chủ backend được chọn sẽ hồi đáp trực tiếp request người dùng. Thường, tất cả các máy chủ trong web-backend phải phục vụ nội dung giống hệt nhau – nếu không, người dùng có thể nhận nội dung không phù hợp.

2. Cân bằng tải layer 7: 

Một cách phức tạp hơn để cân bằng tải lưu lượng mạng là dùng layer 7 (application layer). Dùng layer 7 cho phép load balancer chuyển hướng request đến các máy chủ backend khác nhau dựa trên nội dung request. Chế độ cân bằng tải này cho phép chạy nhiều máy chủ ứng dụng web dưới cùng domain và port.

![alt text](/doc/figure/haproxy3.png)

## Các thuận toán cân bằng tải 

Thuật toán cân bằng tải dùng để xác định máy chủ nào, trong 1 backend, sẽ được chọn khi cân bằng tải. HAProxy cung cấp một số tùy chọn thuật toán. Ngoài việc cân bằng tải dựa trên các thuật toán, các máy chủ có thể được gán tham số weight để tính toán tần số mà máy chủ được chọn, so với các máy chủ khác.

Một vài thuật toán cân bằng tải thông dụng như sau: 

* Roundrobin
Round Robin chọn các máy chủ lần lượt. Đây là thuật toán mặc định.
* Leastconn
Chọn máy chủ đang có ít kết nối đến nhất – khuyên dùng cho các kết nối có session kéo dài. Các máy chủ trong cùng backend cũng được xoay vòng theo cách roundrobin.
* Source
Chọn máy chủ dựa trên 1 hash của source IP, ví dụ IP address của người dùng của bạn. Đây là 1 phương pháp nhằm đảm bảo rằng 1 người dùng sẽ kết nối đến cùng 1 máy chủ.

## Health Check
HAProxy dùng health check để xác định nếu 1 máy chủ trong backend sẵn sàng xử lý request. Điều này tránh việc thủ công loại bỏ 1 máy chủ khỏi backend nếu nó không sẵn sàng. Mặc định health check tạo 1 kết nối TCP đến máy chủ, ví dụ nó kiểm tra nếu 1 máy chủ backend đang lắng nghe trên IP address và port đã được cấu hình.

Nếu một máy chủ không sẵn sàng khi health check, và vì thế không thể xử lý request, nó được tự động vô hiệu hóa trong backend. Ví dụ lưu lượng sẽ không được chuyển hướng đến cho đến khi nó sẵn sàng. Nếu tất cả các máy chủ trong backend lỗi, dịch vụ sẽ không sẵn sàng cho đến khi ít nhất 1 máy chủ trong backend sẵn sàng phục vụ.

Đối với 1 số loại backend nhất định, như máy chủ cơ sở dữ liệu, health check mặc định là không đủ để xác định máy chủ vẫn còn khỏe.