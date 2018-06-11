# JDK
## 1. Install 
Cài đặt Oracle JDK 8 trên ubuntu 16.04

1. Thêm Oracle's PPA vô package repository, rồi update
```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
```
2. Cài đặt Oracle JDK 8 
```
sudo apt-get install oracle-java8-installer
```
**Lưu ý**: Có thể cài đặt nhiều phiên bản jdk trên cùng một máy chủ. Cài đặt phiên bản mặt định bằng lệnh sau: 
```
sudo update-alternatives --config java
```
Ouput của lệnh trên sẽ có format như sau:
```
Here are 5 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                            Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      auto mode
  1            /usr/lib/jvm/java-6-oracle/jre/bin/java          1         manual mode
  2            /usr/lib/jvm/java-7-oracle/jre/bin/java          2         manual mode
  3            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode
  4            /usr/lib/jvm/java-8-oracle/jre/bin/java          3         manual mode
  5            /usr/lib/jvm/java-9-oracle/bin/java              4         manual mode

Press <enter> to keep the current choice[*], or type selection number:
```
Chọn số thứ tự tương ứng với phiên bản JDK ta muốn sử dụng mặc định.

## 2. Cài đặt JAVA_HOME ENVIROMENT Variable 

Nhiều chương trình sử dụng biến JAVA_HOME để  tham chiếu tới  Java installation folder. Vì vậy ta phải set biết JAVA_HOME về  path của thư mục JDK ta vừa cài đặt 
Thực hiện như sau: 
1. Edit _/etc/enviroment thêm vào cuối file dòng sau, thay _"/usr/lib/jvm/java-8-oracle"_ bằng đường dẫn đến thư mục cài đặc JDK của bạn.
```
JAVA_HOME="/usr/lib/jvm/java-8-oracle"
```
2. Save & Reload 
```
source /etc/enviroment
```
