# Java Virtual Machine

![alt text](/doc/figure/program_run.png)

Tất cả chương trình nếu muốn thực thi được thì đều phải được biên dịch ra mã máy, kiến trúc trên các vi xử lý khác nhau thì khác nhau, các OS cũng có các tập lệch riêng biệt mà chỉ chạy được trên OS đó thôi. Ví dụ như chương trình sau khi biên dịch trên window sẽ có đuôi là .exe. Trên linux thì có đuôi .ELF, chươn trình được biên dịch trên Window thì không thể chạy trên Linux cũng như các nền tảng khác và ngược lại. Nếu muốn thì lập trình viên phải chỉnh sửa và biên dịch lại từ đầu, rất khó khăn & mất thời gian.

Từ khi ngôn ngữ Java ra đời, cùng với máy ảo Java (JVM) thì khó khăn trên đã được khắc phục dễ dàng. Một chương trình Java sẽ được biên dịch thành Java ByteCode (chạy trên JVM), và JVM sẽ đảm nhận trách nhiệm dịch bytecode đó thành mã máy tưng ứng. JVM có nhiều phiên bản & có thể chạy trên nhiều nền tảng khác nhau.

## Định nghĩa 
Java Virtual Machine (JVM) là máy ảo cung cấp môi trường dùng để chạy ứng dụng được viết bằng Java.
Nhờ JVM mà một chương trình Java có thể chạy trên nhiều nền tảng khác nhau. Bất cứ nền tảng nào, nếu muốn khởi chạy Java thì buộc phải chạy máy ảo này.

![alt text](/doc/figure/jvm1.jpg)

## Các thành phần chính của JVM
* Class Loader: là một hệ thống con của JVM, có nhiệm vụ là tải các class được định nghĩa.
* Class Area:  lưu trữ cấu trúc của các class, parameter, method của class và code của các method.
* Heap: là vùng nhớ dùng để lưu trữ các đối tượng được khởi tạo trong quá trình thực thi.
* Stack: Chứa các frame, mỗi frame chứa các biến cục bộ & kết quả cục bộ, thực thiện một phần nhiệm vụ trong việc triệu hồi và trả về method. Mỗi thread có một stack riêng được khởi tạo cùng với Thread. Mỗi frame sẽ được tạo khi một hàm được gọi & bị hủy khi hàm thực thi xong.
* Programming Counter Register: Chứa địa chỉ lệnh JVM hiện tại đang thực thi. 
* Native Method Stack: chứa các hàm của hệ thống (phương thức tự nhiên  ) được sử dụng trong chương trình.
* Execution Engine: là một hệ thống bao gồm: bộ xử lý ảo Virtual Processor , trình thông dịch Interpreter (Đọc Java Bytecode Stream và thực thi các chỉ thị)
*  JIT (Just-in-time) compiler được sử dụng để cải thiện hiệu suất. JIT biên dịch các phần của Bytecode mà có cùng tính năng tại cùng một thời điểm, và vì thế giảm lượng thời gian cần thiết để biên dịch. Ở đây khái niệm Compiler là một bộ biên dịch tập chỉ thị của JVM thành tập chỉ thị của một CPU cụ thể.

.
Nhiệm vụ chính của JVM: tải code, kiểm tra code, thực thi, cung cấp môi trường runtime.

![alt text](/doc/figure/cau_truc_jvm.JPG)

## Cơ chế làm việc của JVM

JVM được chia thành 3 module chính: 
1. Class-Loader Subsytem: tìm kiếm và load các file .class vào vùng nhớ của Java.
2. Runtime Data Area: vùng nhớ hệ thống cấp phát cho JVM.
3. Execution Engine: chuyển các lệnh của JVM trong file .class thành các lệnh của máy, hệ điều hành tương ứng và thực thi chúng.
![alt text](/doc/figure/jvm2.png)
## Bộ nhớ trong JVM

* Java Heap: JVM lưu tất cả các đối tượng được khởi tạo bằng toán tử "new" trong ứng dụng Java vào Heap ngay tại thời  điểm chạy. Khi ứng dụng không còn tham chiếu tới các đối tượng ấy nữa, Java Garbage Collector cho phép xóa đối tượng này đi để  sử dụng lại vùng nhớ đó.

* Java Stack: Các method và các tham chiếu tới đối tượng cục bộ được lưu trong Stack. Mỗi thread được quản lý một stack. Khi được gọi, method được đẩy vào đỉnh của stack.  Stack lưu giữ trạng thái của method trên một vùng nhớ gồm: dòng code thực thi, tham chiếu tới đối tượng cục bộ.   Khi mothod chạy xong, vùng nhớ đó được đẩy ra khỏi stack và tự động giải phóng.

* Java Perm: Lưu trữ thông tin của Class được nạp vào và một vài tính năng khác như StringPool (vùng nhớ của biến String) thường được tạo bởi phương thức String.interm(). Khi ứng dụng chạy, Perm space được lấp đầy nhanh chóng.

