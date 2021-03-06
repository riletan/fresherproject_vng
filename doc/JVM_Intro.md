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

### JDK (Java Development Kit) Bao gồm JRE và Các Development Tool khác.

## JVM Monitoring 

Nhiều ứng dụng Java sau một thời gian sử dụng, số lượng người dùng và lượng dữ liệu gia tăng cũng làm thay đổi hiệu năng của ứng dụng, nguyên hiểm hơn có thể dẫn đến ứng dụng bị chết hoặc unresponsive.\
Vì vậy, việc theo dỗi các thông số của jvm trong suốt thời gian vận hành hệ thống là rất quan trọng để có thể kịp thời điểu chỉnh hoặc sửa chữa nếu có sự cố xảy ra.

Một vài thông số  quan trọng của jvm cần theo dõi như: 
* Memomry
* Garbage Collection (Qua trình thu dọn bộ nhớ).
* Hoạt động biên dịch (JIT Compilation).
* Class loading.

Trong đó, các thông số về Memory và GC là quan trọng nhất, phải ánh nhiều nhất về  hoạt động và hiệu năng của JVM.

### 1. Memory
Bao gồm: 
* Heap Memory
* Non-Heap Memory
* Memory Pool
    * PS Old gen
    * PS Eden Space
    * PS Survivor Space
    * Metaspace
    * Code cache
    * Compressed Class Space

### 2. Garbage Collection Monitoring 
#### Các khái niệm cơ bản.
**Garbage Collection** là quá trình xác định và loại bỏ các Obj không được sử dụng (unreferenced) khỏi bộ nhớ heap. 
**Garbage collectioner** là chương trình chạy nền, nó theo dõi toàn bộ các Obj trong bộ nhớ heap và tìm ra những Obj không được tham chiếu đến nữa và loại bỏ chúng đi.\
Quá trình GG bao gồm 3 bước cơ bản: 
1. **Marking**: Đánh dấu những Obj còn sử dụng & không còn sử dụng.
2. **Normal deleteting**: GC sẽ xóa các Obj không còn sử dụng nữa.
3. **Deletion with compacting**: Những obj còn được sử dụng được gom lại gần nhau để làm tăng hiệu suất sử dụng bộ nhớ trống cấp phát cho các Obj mới.

Để thực hiện việc tự động giải phóng các Obj không được sử  dụng, Bộ nhớ Heap được chia thành các phần nhỏ như dưới đây: 

![alt text](/doc/figure/gc1.png)

**Young Generation** là nơi chứa toàn bộ Obj khi mới được khởi tạo, nó được chia thành 3 vùng nhỏ hơn là Eden và 2 vùng Survivor S0, S1. Khi YG đầy thì Minor GC hoạt động.\
Ban đầu thì mọi Obj mới tạo sẽ được chứa ở Eden. Khi Eden đầy thì Minor GC chuyển chúng sang vùng S0,S1.\
Minor GC liên tục theo dõi các Object ở S0, S1. Sau nhiều chu kỳ quét mà Object vẫn còn được sử dùng thì chúng mới được chuyển sang vùng nhớ Old generation. Old generation được quản lý bởi Major GC.\
Mô hình vùng nhớ Heap có vùng Perm (Permanent Generation), Perm không phải một phần của Heap. Perm không chứa Object, nó chứa metadata của JVM như các thư viện Java SE, mô tả các class và các method của ứng dụng.

![alt text](/doc/figure/gc2.png)


**Các thông số cần quan tâm về GC**
* Kích thước của Java Heap
* Kích thước của vùng young generation, old generation và permanent generation.
* Thời gian và tần suất thực hiện và dung lượng vùng nhớ thu hồi được từ minor garbage collection.
* Thời gian và tần suất thực hiện và dung lượng vùng nhớ thu hồi được từ major garbage collection.
* Sự chiếm giữ vùng nhớ của young generation, old generation và permanent generation trước và sau khi thực hiện garbage collection.

### 3. Classloading
Bao gồm: 
* Current classes loaded 
* Total classes loaded
* Total classes unloaded

### Các công cụ theo dõi JVM được tích hợp trong bộ JDK.
1. **jps**: [Java Virtual Machine Process Status Tool](https://docs.oracle.com/javase/7/docs/technotes/tools/share/jps.html)\
**jps** có công dụng là tìm và hiển thị pid của tất cả các tiến trình java đang ở trạng thái running trong hệ thống.\
![alt text](/doc/figure/jps.png) 
2. **jstat**: [Java Virtual Machine Statistics Monitoring Tool](https://docs.oracle.com/javase/7/docs/technotes/tools/share/jstat.html)
    Jstat là công cụ dùng để thống kê các perfomence data của JVM. Sử dụng:
    ```
    jstat [ generalOption | outputOptions vmid [interval[s|ms] [count]] ]
    ```
    Ví dụ: Ta sẽ sử dụng jstart để xem các thông số của jvm "Hello" bằng các bước sau:\
    Bước 1: Sử dụng **jps** để xem pid của jvm Hello
    ```
    root@ri-hp6200:~# jps
    10707 Jps
    8267 JConsole
    8207 Hello
    root@ri-hp6200:~# 
    ```
    Bước 2: Biết được pid của Hello là 8207, Tiếp theo sử dụng jstat để lấy các thông số.
    ```
    jstat -gcutil 8207 250 7
    ```
    Lệnh trên sẽ kết nối với jvm Hello và thực hiện lấy mẫu mỗi 250ms 1 lần và lấy 7 mẫu trước khi kết thúc.
    ```
     S0     S1     E      O      M     CCS    YGC     YGCT    FGC    FGCT     GCT   
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  39.35   0.01  93.89  84.87      2    0.007     0    0.000    0.007
    20.94   0.00  40.08   0.01  93.89  84.87      2    0.007     0    0.000    0.007

    ```
    Trong đó:`
    * S0, S1, E, 0, M, CSS: Lần lượt là thông năng sử dụng hiện tại của Survivor space 0, 1, Eden space, Old space, Metaspace & Compressed Class Space (Thuộc Perm Space) tính theo %.
    * YGC: Số lần diễn ra GC ở Young Generation. (Minor GC) 
    * YGCT - Young generation garbage collection time: Thời giang diễn ra Minor GC. 
    * FGC: Số lẫn full GC.
    * GCT: Tổng thời gian diễn ra GC.

    Để thấy rõ hơn hoạt động GC, ta xem ví dụ sao (trích: [Oracle Doc](https://docs.oracle.com/javase/7/docs/technotes/tools/share/jstat.html))
    
    ```
    S0     S1     E      O      P     YGC    YGCT    FGC    FGCT     GCT

    12.44   0.00  27.20   9.49  96.70    78    0.176     5    0.495    0.672

    12.44   0.00  62.16   9.49  96.70    78    0.176     5    0.495    0.672

    12.44   0.00  83.97   9.49  96.70    78    0.176     5    0.495    0.672

     0.00   7.74   0.00   9.51  96.70    79    0.177     5    0.495    0.673

     0.00   7.74  23.37   9.51  96.70    79    0.177     5    0.495    0.673

     0.00   7.74  43.82   9.51  96.70    79    0.177     5    0.495    0.673

     0.00   7.74  58.11   9.51  96.71    79    0.177     5    0.495    0.673
    
    ```

    Có thể thấy rằng quá trình Minor GC diễn ra giữa mẫu thứ 3 và thứ 4. Thời gian GC là 0.001 giây. GC chuyển Obj từ E sang O, (E từ 83.97% về 0, O từ 9.49% lên 9.52%). Survivor Space trước khi GC sử dụng hết 12.44%, sau khi GC còn 7.74%.

    Ngoài ra còn nhiều generalOption khác như -gc, -gccapacity, gccause, gcnew, gcnewcapacity,... Nhưng được sử dụng nhiều nhất là -gc & -gcutil.
    

3. **jconsole**: Jconsole là phần mềm quản lí và theo dõi jvm có giao diện đồ họa. Jconsole hỗ trợ cả JMX lẫn MBean, nhờ đó Jconsole có thể theo dỗi nhiều jvm cùng một lúc. Hơn nữa, nhiều Session của Jconsole có thể cùng theo dõi một session của một JVM. Các thông số Jconsole có thể theo dõi:
* Memory usage by memory pool/spaces
* Garbage collection
* JIT compilation
* Class loading
* Threading and logging
* Thread monitor contention
* Thread monitor contention

![alt text](/doc/figure/jconsole.png)