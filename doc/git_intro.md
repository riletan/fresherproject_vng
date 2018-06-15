# Hệ thống quản lý phiên bản
[](https://git-scm.com/book/vi/v1)
Lời mở đầu
```
- Quản lý phiên bản (VCS- Version Control System): là hệ thống lưu trữ các thay đổi của một hoặc nhiều tập tin theo thời gian. Bất kỳ loại file nào cũng có thể được sử dụng trong quản lý phiên bản.
- VCS cho phép: 
 + Khôi phục lại phiên bản cũ hơn của 1 file, 1 vài file hay toàn bộ project về một trạng thái trước đó.
 + Xem lại các thay đổi đã được thực hiện theo thời gian, ai là người thực hiện,...
 + Quá trình khôi phục diễn ra nhanh chóng & không tốn nhiều công sức.
- CVCS - Centralized VCS - VCS Tập trung (CVS, Subversion, Perforce,...): Bao gồm một server có chứa các file đã được "phiên bản hóa" (verisioned) và danh sách các client có quuyền thay đổi các tập tin đó. 
- DVCS - Distributed VCS - VCS Phân tán: Các client không chỉ "check out" - sao chép về máy cục bộ phiên bản mới nhất của file (CVCS). chúc mirror toàn bộ repository file (Kho chứa dữ liệu)

```
Hình 1. Mô hình hệ thống quản lý phiên bản tập trung:\
![alt text](/doc/figure/cvcs.png)\
Hình 2. Mô hình hệ thống quản lý phiên bản phân tán:\
![alt text](/doc/figure/dvcs.png)

# Git 
## Định nghĩa, đặt điểm cơ bản, nguyên lí hoạt động.
 - **Git** là một hệ thống quản lý phiên bản phân tán được phát triển ban đầu dùng để quản lý mã nguồi Linux.
 - **Git** không lưu trữ thông tin dưới dạng danh sách các tập tin được thay đổi, thay vào đó Git coi dữ liệu như là một tập hợp các snapshot (ảnh) của dữ liệu và lưu giữ chúng theo thời gian. 
 - Nếu như tập tin không có sự thay đổi nào, **Git** không lưu trữ tập tin đó lại một lần nữa mà chỉ tạo một liên kết tới tập tin gốc đã tồn tại trước đó. Git thao tác với dữ liệu giống như Hình 4.

  Hình 4. Mô phỏng các hệ thống hướng tới lưu trữ tập tin dưới dạng các thay đổi so với bản cơ sở của mỗi tập tin.\
  ![alt text](/doc/figure/git1.png)\
  Hình 4. Git lưu trữ dữ liệu dưới dạng ảnh chụp của dự án theo thời gian.\
  ![alt text](/doc/figure/git2.png)

   - Phần lớn các thao tác trên **Git** diễn ra cục bộ, không yêu cầu phải có kết nối internet hay kết nói vật lý tới máy khác.
 - Tính toàn vẹn: 
    * Mọi thứ trong **Git** được băm (checksum, hash) trước khi được lưu trữ và được tham chiếu tới bằng mã băm đó, nên việc thay đổi một tập tin mà để git không biết đến là điều không thể. 
    * Hàm băm được Git sử dụng là SHA-1: Mã băm gồm một chuỗi số  thập lục phân gồm 40 ký tự. Được tính toán từ nội dung của file hoặc cấu trúc của thư mục trong **Git**. 
    * Git sử dụng mã băm này vào một CSDL có thể truy vấn được để  định danh và lưu trữ các tập tin thay vì tên của chúng.
 - **Git** chỉ thêm mới dữ liệu -> Có thể phục hồi lại tất cả mọi thứ.
 - Mỗi tập tin trong Git được quản lý dựa trên 3 trạng thái: Commitited, modified và staged.
 * **Commitited** tập tin đã được lưu trữ an toàn trong CSDL.
 * **Modified** tập tin đã được thay đổi nhưng chưa commit lên CSDL.
 * **Staged** tập tin đã được thay đổi & được đánh dấu là sẽ commit phiên bản hiện tại đó trong lần commit tới.

 ![alt text](/doc/figure/git3.png)

  - Một workflow cơ bản của **Git**
  1. Thay đổi các tập tin trong Working directory
  2. Tổ chức các tập tin, tạo mới snapshot của các tập tin vào staging area.
  3. Commit, snapshot của các tập tin sẽ được lưu trữ vĩnh viễn lên Git repository.

  ## Cài đặt trên linux
   ### Cài đặt từ source code để có phiên bản mới nhất. 
   1. Cài đặt các thư viện mà **Git** sử dụng:
   ```
   ##Centos/RedHat
   yum install curl-devel expat-devel gettext-devel  openssl-devel zlib-devel
   ##Ubuntu/Debian 9
   apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
   ```
   2. Tải về phiên bản mới nhất từ [kernel.com](https://mirrors.edge.kernel.org/pub/software/scm/git/)
   3. Compile và cài đặt:
   ```
   tar -zxf git-2.9.5.tar.gz
   cd git-2.9.5
   make prefix=/usr/local all
   sudo make prefix=/usr/local install
   ```
   4. Sao khi cài đặt, có thể udpate chính **Git** bằng lệnh sau:
   ```
   git clone git://git.kernel.org/pub/scm/git/git.git
   ```
   ### Cài đặt từ linux package repository
    
    ##Centos/RedHat
    yum install git-core
    ##Ubuntu/Debian 9
    apt-get install git





