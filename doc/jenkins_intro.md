# <span style="color:red"> Jenkin </span>
 Nguồn: [viblo.asia](https://viblo.asia/p/continuous-integration-with-jenkins-bai-1-gioi-thieu-ve-ci-va-jenkins-OeVKBggEZkW)

 # <span style="color:blue"> I.  Continuous Integration (CI) </span>
 ## <span style="color:blue"> 1. Định nghĩa </span>
    CI- Tích hợp liên tục là phương pháp phát triển phần mềm yêu cầu các thành viên trong nhóm tích hợp công việc một cách thường xuyên và liên tục. Việc chạy thử  nghiệm và kiểm tra sẽ được một nhóm khác thực hiện để phát hiện lỗi nhanh nhất có thể. Phương pháp này giúp giảm độ phức tạm của việc tích hợp và cho phép phát triển phần mềm gắn kết nhanh hơn.

## <span style="color:blue"> 2. CI Workflow </span> 
![alt text](/doc/figure/ci_workflow.jpg)

##  <span style="color:blue"> 3. Các đặc điểm của CI: </span>
* Quản lý phiên bản (source control and version control ).
* Tự động build bao gồm test.
* Đôi ngũ phát triển thường xuyên chuyển (commit) source về nơi lưu trữ chính (mainline).
* Mỗi khi code có thay đổi sẽ build lại (mainline) thông qua build server.
* Báo lỗi cho người lập trình gây lỗi và quản lý dự án.
* Phát hành phiên bản hoàn chỉnh cho khách hàng khi không còn lỗi.
* Tự động phân phối phiên bản mới đến khách hàng.
* Mọi người có thể nhìn thấy những gì đã xảy ra (thay đổi, lỗi…) để xem xét và giải quyết kịp thời.

Tuy nhiên, để triên khai hệ thống tích hợp liên tục, ta sẽ gặp những khó khăn như sau:
* Cần thời gian thiết lập hệ thống ban đầu.
* Đòi hỏi quản lý dự án, người lập trình, người kiểm định phải am hiểu mô hình phát triển phần mềm Agile, hệ thống tích hợp CI, cách sử dụng các công cụ hỗ trợ cho Agile và CI.
* Chi phí thiết bị phần cứng (các server cho CI).\
![alt text](/doc/figure/Agile.jpg)

##  <span style="color:blue"> 4. Lợi ích của CI: </span>
* Giảm thiểu rủi ro do lỗi được phát hiện sớm.
* Giảm thiểu sự lặp lại cho các quá trình
* Tạo phần mềm có giá trị sử dụng sớm nhất có thể và sẳn sàng triểnkhai mọi lúc mọi nơi.
* Cung cấp cái nhìn xuyên suốt tổng quan và cụ thể cho từng giai đoạn.
* Nâng cao kỹ năng của đội ngũ nhân viên phát triển phần mềm.
* Cải thiện chất lượng phần mềm

 # <span style="color:blue"> II. Jenkins </span>
 ## <span style="color:blue"> 1. Giới thiệu </span>
* Là một ứng dụng web application mã nguồn mở (MIT), đóng vai trò máy chủ build & test của hệ thống CI.
* Jenkins được phát triển bằng Java nên Jenkins có thể kết hợp được với hầu hết các công cụ khác của hệ thống CI với nhiều nền tảng khác nhau.
* Tiền thân là Hudson được viết bởi Kosuke Kawaguchi tại Sun, kể từ khi Sun được mualại bởi Oracle vào năm 2010, một bộ phận phát triển Hudson đã tách ra phát triển riêng và đặt tên là Jenkins.
* Được sử dụng rộng rãi và được phát triển cải tiến liên tục bởi cộng đồng mã nguồn mở
* Đạt nhiều giải thưởng :InfoWorld Bossies Award, 2011 O'Reilly Open-Source Award, 2011ALM&SCM, SDTimes 100, 2010, 2011 ,GlassFish Community Innovation Award 2008, Duke'sChoice Award 2008
* Được các tổ chức lớn tin dùng: Ebay,Apache, NASA,Boeing,Mozilla, Linked in,…
## <span style="color:blue"> 2. Đặt điểm </span>
* Dễ dàng cài đặt và sử dụng.
* Đa nền tảng.
* Hỗ trợ cho nhiều công nghệ phát triển phần mềm.
* Được sử dụng rộng rãi.
* Dễ mở rộng.
* Dễ dàng liên kết với các công cụ khác của hệ thống tích hợp liên tục thông qua các plug in.
* Miễn phí.

## <span style="color:blue"> 3. Vai trò của Jenkins trong hệ thống </span>
![alt text](/doc/figure/jenkins.png)

* Là trái tim của hệ thống CI - CI server (build & test) là trung tâm cho mọi hoạt động của hệ thống.
* Jenkins CI giúp khép kín quy trình phần mềm một cách tự động. 
* Giảm thời gian và chi phí, nâng cao năng lực nhân viên.

## <span style="color:blue"> 4. Cài đặt Jenkins trên Ubuntu 16.04/ Debian 9 </span>
### <span style="color:blue"> Bước 1. Thêm Jenkin Key vào Package Repo </span>
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
```
Thêm dòng dưới đây vào file _/etc/apt/sources.list
```
deb https://pkg.jenkins.io/debian-stable binary/
```
### <span style="color:blue"> Bước 2. Apt Uptate & Cài đặt jenkins </span>
**Lưu ý:** Jenkins yêu cầu phải có JRE/JDK cài đặt sẵn.

```
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
```
### <span style="color:blue"> Bước 3. Configure Firewall </span>
Vì Jenkins chạy trên port 8080 nên ta sẽ config firewall cho phép port 8080 
```
sudo ufw allow 8080
```

### <span style="color:blue"> Bước 4. Cài đặt Jenkins </span>
Truy cập vào _http://ip_address_or_domain_name:8080 , đầu tiên ta sẽ bắt gặp "Unlock Jenkins Screen", sử dụng lệnh dưới đây để xem password admin hiện tại. 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Sử dụng mật khẩu này để đăng nhập lần đầu tiên\
![alt text](/doc/figure/jenkins1.png)

Tiếp theo là màn hình cài đặt các plugins, ta có thể chọn "Install suggeted plugins" quá trình cài đặt sẽ diễn ra tự động & cài đặt những plugins thường dùng hoặc chọn "Select plugins to install" để  tùy ý chọn các plugins nào ta muốn cài đặt.\
![alt text](/doc/figure/jenkins-plugins.png)

Tiếp theo sẽ đến màn hình thiết lặp lại url, ta có thể  tùy chỉnh lại url tùy ý thay vì _ip:8080_. Cuối cùng là màn hình tạo user admin đầu tiên 

![alt text](/doc/figure/jenkins2.png)

Ta có thể  tạo một tài khoản admin mới hoặc bỏ qua bước này và tiếp tục đăng nhập bằng mật khẩu inital lúc ban đầu.\
Cuối cùng, nhấn "Start using Jenkins" Site Jenkins dashboard sẽ có dạng như sau:

![alt text](/doc/figure/jenkins3.png)

<span style="color:red"> Thành công! </span>