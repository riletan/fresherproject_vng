# Java Virtual Machine
https://www.w3schools.in/java-tutorial/java-virtual-machine/

![alt text](/doc/figure/program_run.png)

Tất cả chương trình nếu muốn thực thi được thì đều phải được biên dịch ra mã máy, kiến trúc trên các vi xử lý khác nhau thì khác nhau, các OS cũng có các tập lệch riêng biệt mà chỉ chạy được trên OS đó thôi. Ví dụ như chương trình sau khi biên dịch trên window sẽ có đuôi là .exe. Trên linux thì có đuôi .ELF, chươn trình được biên dịch trên Window thì không thể chạy trên Linux cũng như các nền tảng khác và ngược lại. Nếu muốn thì lập trình viên phải chỉnh sửa và biên dịch lại từ đầu, rất khó khăn & mất thời gian.

Từ khi ngôn ngữ Java ra đời, cùng với máy ảo Java (JVM) thì khó khăn trên đã được khắc phục dễ dàng. Một chương trình Java sẽ được biên dịch thành Java ByteCode (chạy trên JVM), và JVM sẽ đảm nhận trách nhiệm dịch bytecode đó thành mã máy tưng ứng. JVM có nhiều phiên bản & có thể chạy trên nhiều nền tảng khác nhau.

## Định nghĩa 
Java Virtual Machine (JVM) là máy ảo cung cấp môi trường dùng để chạy ứng dụng được viết bằng Java.
Nhờ JVM mà một chương trình Java có thể chạy trên nhiều nền tảng khác nhau. Bất cứ nền tảng nào, nếu muốn khởi chạy Java thì buộc phải chạy máy ảo này.

Các đặt điểm chính của JVM:
* JVM là công cụ để chạy chương trình java (JVM is the engine that drives the Java code).
* Ở hầu hết các ngôn ngữ lập trình khác, trình biên dịch (complier) sinh ra code cho một hệ thống cụ thể nào đó, còn Java compiler chỉ sinh ra code cho JVM.
* Khi biên dịch một chương trình Java, một bytecode được sinh ra, và bytcode đó có thể chạy được trên bất kì nền tảng nào. 
* Bytecode là ngôn ngữ trung gian giữ Java source và hệ thống đích (mã máy). 
* It is the medium which compiles Java code to bytecode which gets interpreted on a different machine and hence it makes it Platform/Operating system independent.
JVM ra đời nhằm mục đích: 
* Dich chương trình Java ra mã máy chạy trên được nhiều nền tảng khác nhau.
* Tăng tốc độ
* Nâng cao bảo mật & trách virus phá hủy source code

![alt text](/doc/figure/jvm1.jpg)

## Hoạt động của JVM
![alt text](/doc/figure/jvm_diagram.png)

JVM sẽ:
* Đọc bytecode steam
* Kiểm tra bytecode 
* Link với các thư viện,
JVM sẽ taọ ra file .class(bytecode) có thể chạy trên bất kì OS nào, miễn là phải có JVM cài đặt sẵn vì JVM là nền tảng phụ thuộc.

## Cơ chế làm việc của JVM
JVM được chia thành 3 module chính: 
1. Class-Loader Subsytem: tìm kiếm và load các file .class vào vùng nhớ của Java.
2. Runtime Data Area: vùng nhớ hệ thống cấp phát cho JVM.
3. Execution Engine: chuyển các lệnh của JVM trong file .class thành các lệnh của máy của hệ điều hành tương ứng và thực thi chúng.

![alt text](/doc/figure/jvm2.png)

Class Loader là một hệ thống con của JVM, tìm kiếm và load các file .class vào vùng nhớ dưới dạng bytecode

Sau khi Classloader làm xong nhiệm vụ của mình các file sẽ được máy ảo JVM cung cấp bộ nhớ tương ứng với chúng.
* Class Area: là vùng nhớ cấp phát cho class(method) trong đó lại phân chia thành heap, stack, PC register, native method stack.
* Heap: là vùng nhớ dùng để lưu trữ các đối tượng được khởi tạo trong quá trình thực thi.
* Stack: Chứa các frame, mỗi frame chứa các biến cục bộ & kết quả cục bộ, thực thiện một phần nhiệm vụ trong việc triệu hồi và trả về method. Mỗi thread có một stack riêng được khởi tạo cùng với Thread. Mỗi frame sẽ được tạo khi một hàm được gọi & bị hủy khi hàm thực thi xong.
* Programming Counter Register: Chứa địa chỉ lệnh JVM hiện tại đang thực thi. Khi cần thiết, có thể thay đổi nội dung thanh ghi để đổi hướng thực thi của chương trình. Trong trường hợp thông thường thì từng lệnh một nối tiếp nhau sẽ được thực thi.
* Native Method Stack: chứa các method native được sử dụng trong chương trình.
* Execution Engine: là một hệ thống bao gồm: bộ xử lý ảo Virtual Processor , trình thông dịch Interpreter (Đọc Java Bytecode Stream và thực thi các chỉ thị)
*  JIT (Just-in-time) compiler được sử dụng để cải thiện hiệu suất. JIT biên dịch các phần của Bytecode mà có cùng tính năng tại cùng một thời điểm, và vì thế giảm lượng thời gian cần thiết để biên dịch. Ở đây khái niệm Compiler là một bộ biên dịch tập chỉ thị của JVM thành tập chỉ thị của một CPU cụ thể.
* Java Perm: Lưu trữ thông tin của Class được nạp vào và một vài tính năng khác như StringPool (vùng nhớ của biến String) thường được tạo bởi phương thức String.interm(). Khi ứng dụng chạy, Perm space được lấp đầy nhanh chóng.

![alt text](/doc/figure/cau_truc_jvm.JPG)
https://daynhauhoc.com/t/java-virtual-machine-va-co-che-hoat-dong/15082
//TODO
Ví dụ
```
Person person = new Person ();
//Heap: lưu đối tượng Person khi ta “new Person ();”
//Stack: lưu tham chiếu “person ”.
//Perm: lưu thông tin về Class “Person ”.
```
## Nền tảng độc lập (Platform Independent)
Java được gọi là một nền tảng độc lập bởi vì JVM.: Khi ta summit một file .class trên bất kì OS nào, chạy trên nhiều máy tính khác nhau, miễn là nó có JVM được cài đặt sẵn, thì code đó sẽ được JVM biên dịch thành mã máy tương ứng.
* JVM là thành phần chính trong kiến trúc của Java, là một bộ phận của JRE (Java Runtime Enviroment)
* JVM được viết bằng ngôn ngữ C, JVM là một nền tảng phụ thuộc. (Mỗi OS khác nhau thì phải có một bản JVM riêng biệt)
* JVM chịu trách nhiệm cấp phát vùng nhớ cần thiết cho chương trình Java & giải phóng không gian nhớ sau khi sử dụng xong.

## JRE-JDK-JVM

![alt text](/doc/figure/differ.png)

### JRE - Java Runtime Enviroment

JRE cung cấp môi trường runtime, nó là một triển khai của JVM. JRE bao gồm tập các thư viện và các file khác mà JVM sử dụng trong runtime. Trình triển khai của JVM cũng được công bố bởi các công ty khác ngoài Sun Micro Systems

### JDK Bao gồm JRE và Các Development Tool khác.


