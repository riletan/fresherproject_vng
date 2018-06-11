# Java Virtual Machine
https://www.w3schools.in/java-tutorial/java-virtual-machine/

![alt text](/doc/figure/program_run.png)

Tất cả chương trình nếu muốn thực thi được thì đều phải được biên dịch ra mã máy, kiến trúc trên các vi xử lý khác nhau thì khác nhau, các OS cũng có các tập lệch riêng biệt mà chỉ chạy được trên OS đó thôi. Ví dụ như chương trình sau khi biên dịch trên window sẽ có đuôi là .exe. Trên linux thì có đuôi .ELF, chươn trình được biên dịch trên Window thì không thể chạy trên Linux cũng như các nền tảng khác và ngược lại. Nếu muốn thì lập trình viên phải chỉnh sửa và biên dịch lại từ đầu, rất khó khăn & mất thời gian.

Từ khi ngôn ngữ Java ra đời, cùng với máy ảo Java (JVM) thì khó khăn trên đã được khắc phục dễ dàng. Một chương trình Java sẽ được biên dịch thành Java ByteCode (chạy trên JVM), và JVM sẽ đảm nhận trách nhiệm dịch bytecode đó thành mã máy tưng ứng. JVM có nhiều phiên bản & có thể chạy trên nhiều nền tảng khác nhau.

## 1. Định nghĩa 
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

## 2. Hoạt động của JVM
![alt text](/doc/figure/jvm_diagram.png)

JVM sẽ:
* Đọc bytecode steam
* Kiểm tra bytecode 
* Link với các thư viện,
JVM sẽ taọ ra file .class(bytecode) có thể chạy trên bất kì OS nào, miễn là phải có JVM cài đặt sẵn vì JVM là nền tảng phụ thuộc.

## 3. Cơ chế làm việc của JVM
JVM được chia thành 3 module chính: 
1. **Class-Loader Subsytem**: tìm kiếm và load các file .class vào vùng nhớ của Java.
2. **Runtime Data Area**: vùng nhớ hệ thống cấp phát cho JVM.
3. **Execution Engine**: chuyển các lệnh của JVM trong file .class thành các lệnh của máy của hệ điều hành tương ứng và thực thi chúng.

![alt text](/doc/figure/jvm3.png)

### 3.1 Class Loader.

![alt text](/doc/figure/jvm2.png)

Class loader đảm nhiệm việc load, link và intit class file khi tồn tại một tham chiếu đầu tiên tới class đó trong quá trình runtime. Tính năng dynamic class loading của Java được sử lý bằng class loader này.
```
Dynamic class loading là một cơ chế  trong java mà nếu như chương trình tham khảo đến một object thuộc một lớp  không được đồng hóa trên JVM hiện tại DCL sẽ tự đi load bytecode của class này và tạo ra một instance của class đó để thực thi công việc. 
```
Trong Class Loader Subsystem có 3 pha xử lý: Loading, Linking và Initialization. 
1. Loading: có 3 bộ loader tham gia vào việc loading
* **Bootstap class loader**: load các class từ bootstap classpath. Có mức ưu tiên cao nhất.
* **Extention class loader**: Load các class nằm trong folder jre/lib
* **Application  Class loader**: Load các class nằm ở tầng ứng dụng.
Trong quá trình hoạt động, 3 bộ loader trên đều chạy dựa trên thuật toán tìm kiếm tài nguyên phân cấp ủy quyền - Delagtion Hierachy Algorithm.
```
Delagtion Hierachy Algorithm
//TODO
```


2. Linking: Chia thành 3 bước sau
* **Verify**: Bộ bytecode verifier sẽ kiểm tra đoạn code được generate có hợp lệ không, nếu không hợp lệ verification sẽ được bắt ra. 
* **Prepare**: ở bước này tất cả các biến static được cấp phát vùng nhớ và gán cho giá trị mặt định.
* **Resolve**: Tất cả các bộ nhớ dạng ký hiệu (symbolic memory interface, reference) được thay thế bởi tham chiếu dạng nguyên thủy (original reference).
3. Intializtion: Là bước cuối cùng, tất cả các biến static sẽ được gán giá trị (giá trị được gán trong *.java) và các static block sẽ được thực thi trong bước này. 


### 3.2 Runtime Data Area

Sau khi Classloader làm xong nhiệm vụ của mình các file sẽ được máy ảo JVM cung cấp bộ nhớ tương ứng với chúng trong **Runtime Data Area** 
1. **Method Area**: nơi lưu trữ dữ liệu mức class, toàn bộ các dữ liệu có trong một class sẽ nằm ở đây. Một JVM chỉ có một Method Area và nó có thể được sử dụng bởi nhiều tiến trình.
2. **Heap Area**: lưu trữ object và các thứ liên quan như instance variable, arrays. Giống như Method Area, Một JVM chỉ có một Heap Area. Vì 2 vùng này được các tiến trình chia sẻ với nhau nên dữ liệu lưu ở đây không đảm bảo **thread-safe**.
3. **Stack Area**: Stack Area đảm bảo **thread-safe** bởi mỗi thread sẽ được cấp phát một **runtime stack**. Tất cả biến cục bộ được tạo trong bộ nhớ stack. Mỗi khi có method call - lệnh gọi hàm, một "lối vào" stack sẽ được "mở", lối vào này mang tên **Stack Frame**. Mỗi Stack Frame chứa 3 thực thể con:

    1. **Local Variable Aray** Mảng các biến cục bộ.
    2. **Operand Stack** ngăn chứa các toán hạng
    3. **Frame Data** chứa các ký hiệu liên quan tớ method. Trong trường hợp exception xảy ra, thông tin gói catch cũng sẽ nằm ở đây.

4. **Programming Counter Register**: Chứa địa chỉ lệnh hiện tại đang thực thi. Khi cần thiết, có thể thay đổi nội dung thanh ghi để đổi hướng thực thi của chương trình. Trong trường hợp thông thường thì từng lệnh một nối tiếp nhau sẽ được thực thi.  Mỗi thread sẽ sở hữu riêng một PC Register.
5. Native Method Stack: giữ các thông tin tự nhiên của method. Mỗi thread đều sở hữu một Native method stack.

### 3.3 Execution Engine
Phần bytecode được gán qua **Runtime Data Area** sẽ được thực thi bởi **Execution Engine**. Module này đọc và thực thi từng đoạn byte code.

**Execution Engine** gồm có 3 module con:
1. **Interpreter** Trình thông dịch: thông dịch bytecode nhanh nhưng có nhược điểm là thực thi chậm. Bên cạch đó, còn có một nhược điểm nữa là method được gọi bao nhiêu lần thì cần bấy nhiêu lần thông dịch.
2. **JIT Compiler - Just In Time Compiler** JIT sẽ trung hòa các nhược điểm của **Interpreter**. Ex-Engine sẽ dùng Interpreter để thông dịch code, và khi nó phát hiện ra code được lập lại, thì sẽ dùng JIT compiler. JIT Compiler sẽ biên dịch toàn bộ bytecode (thay vì từng dòng lệnh như Interpreter) sau đó chuyển dổi thành native code. Chỗ  native code này sẽ được sử dụng trực tiếp cho các lời gọi hàm lặp đi lặp lại. Nhờ đó, hiệu năng được cải thiện đáng kể. Các bước xử lí của Interprefer gồm:  
    1. **Intermediate Code Generator**: Sinh code trung gian.
    2. **Code Optimizer**: Tối ưu mã.
    3. **Target code Generator**: Tạo mã máy hoặc native code.
    4. **Profiler**: Một module đặc biệt, chịu trách nhiệm tìm các điểm nóng (vd: các lời gọi hàm lặp đi lặp lại).
3. **Garbage Collector**: Tìm kiếm và thu dọn các object đã tạo nhưng không được tham chiếu đến. Ta có thể kích hoạt thủ công bộ **GC** thông qua lệnh "**System.gc()** 
4. Hai thành phần cuối của **Ex-Engine** là **JNI - Java Native Interface** và **Native Method Libraries** 
**JNI** sẽ tương tác với **NML** và cung cấp các **Native Libraries** cần thiết cho **Ex-Engine**


![alt text](/doc/figure/jvm4.gif)

Ví dụ
```
Person person = new Person ();
//Heap: lưu đối tượng Person khi ta “new Person ();”
//Stack: lưu tham chiếu “person ”.
```

## JRE-JDK-JVM

![alt text](/doc/figure/differ.png)

### JRE - Java Runtime Enviroment

JRE cung cấp môi trường runtime, nó là một triển khai của JVM. JRE bao gồm tập các thư viện và các file khác mà JVM sử dụng trong runtime. Trình triển khai của JVM cũng được công bố bởi các công ty khác ngoài Sun Micro Systems

### JDK Bao gồm JRE và Các Development Tool khác.


