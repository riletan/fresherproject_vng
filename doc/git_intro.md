# <span style="color:red"> Hệ thống quản lý phiên bản </span>
[](https://git-scm.com/book/vi/v1)
<span style="color:blue"> Lời mở đầu </span>
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

# <span style="color:red"> Git </span> 
## <span style="color:blue"> Định nghĩa, đặt điểm cơ bản, nguyên lí hoạt động. </span>
 - **Git** là một hệ thống quản lý phiên bản phân tán được phát triển ban đầu dùng để quản lý mã nguồi Linux.
 - **Git** không lưu trữ thông tin dưới dạng danh sách các tập tin được thay đổi, thay vào đó Git coi dữ liệu như là một tập hợp các snapshot (ảnh) của dữ liệu và lưu giữ chúng theo thời gian. 
 - Nếu như tập tin không có sự thay đổi nào, **Git** không lưu trữ tập tin đó lại một lần nữa mà chỉ tạo một liên kết tới tập tin gốc đã tồn tại trước đó. Git thao tác với dữ liệu giống như Hình 4.

  Hình 4. Mô phỏng các hệ thống hướng tới lưu trữ tập tin dưới dạng các thay đổi so với bản cơ sở của mỗi tập tin.\
  ![alt text](/doc/figure/git1.png)\
  Hình 5. Git lưu trữ dữ liệu dưới dạng ảnh chụp của dự án theo thời gian.\
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
 - Vòng đời của một tập tin: Mỗi một file trong **Working Directory(WD)** có thể ở một trong hai trạng thái - _tracked_ hoặc _untracked_
    * **Tracked File** là các file đã có trong snapshot trước, chúng có thể là unmodified, modified hoặc staged.
    * **Untracked File** là các file còn lại - các file trong **WD** mà không có trong snapshot trước đó hoặc không có trong **staging area** 
    * Ban đầu khi mới được clone về, tất cả các tập tin đều ở trạng thái  **tracked** và **unmodified**; Khi file bị chỉnh sửa, **Git** coi là chúng đã bị thay đổi so với lần commit trước đó. Sau đó, nó được **staged** và commit lên repo, quá trình này cứ thế lặp đi lặp lại.\
    Hình 6. Vòng đời trạng thái của một file.\
    ![alt text](/doc/figure/git4.png)

  - Một workflow cơ bản của **Git**
  1. Thay đổi các tập tin trong Working directory
  2. Tổ chức các tập tin, tạo mới snapshot của các tập tin vào staging area.
  3. Commit, snapshot của các tập tin sẽ được lưu trữ vĩnh viễn lên Git repository.\
 ![alt text](/doc/figure/git3.png)

  ## <span style="color:blue"> Cài đặt Git trên linux </span>
   ### <span style="color:blue"> Cài đặt từ source code để có phiên bản mới nhất. </span>
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
   ### <span style="color:blue"> Cài đặt từ linux package repository </span>
  
  ```  
    ##Centos/RedHat
    yum install git-core
    ##Ubuntu/Debian 9
    apt-get install git
   ```

  ## <span style="color:blue"> Cấu hình Git </span>
  ### <span style="color:blue"> Reference </span>
  * _/etc/gitconfig_: chứa config cho tất cả các user và repo có trong hệ thống. Khi chạy _git config --system_ tất cả các config sẽ lươi dưới thư mục này.
  * _~/.gitconfig_: chứa config cho riêng mỗi user. Chạy _git config --global_ để configure.
  * _.git/config_: Có hiệu lực cho riêng mỗi repo. 
  Cấp dưới sẽ override config ở cấp trên nó. Ví dụ, Config ở _.git/config_ sẽ có hiệu lực thay vì các config ở _/etc/gitconfig_ nếu chúng cùng quy định một tham số. 

  ### <span style="color:blue"> Định danh </span>
   Muốn commit được thì chúng ta phải khai báo email và tên tài khoản để định danh, email và tên này sẽ gắn liền với các commit.
   ```
   git config --global user.name "RI"
   git config --global user.email "rilt@vng.com.vn"
   ```

   _git config --global_ chỉ cần thực hiện một lần đầu tiên khi sử dụng git, nếu muốn tạo ra định danh riêng biệt cho riêng repo nào đó thì có thể chạy _git config_ mà không có tham số _global_

  ### <span style="color:blue"> Editor </span>
   Mặc định Git sử dụng trình soạn thảo mặc định của hệ thống, thường là Vi hoặc Vim. Nếu muốn thiết lập một trình soạn thảo khác (ví dụ Visual Studio Code) ta thực hiện như sau:
   ```
   git config --global core.editor vscode
   ```

  ### <span style="color:blue"> Merge Tools </span>
  Nếu muốn thay đổi công cụ so sách sự thay đổi ta có thể sử dụng câu lệnh sau:
  ```
  git config --global merge.tool vimdiff
  ```
  Git chấp nhận kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, và opendiff là các công cụ trộn/sát nhập (merge) hợp lệ.

  ### <span style="color:blue">  Verify Config </span>
  Để kiểm tra lại các config:
  ```
  git config --list
  ```

  ## <span style="color:blue"> Sử dụng git </span>
  ### <span style="color:blue">  Khởi tạo Repository từ một thư mục có sẵn </span>
  chuyển working directory tới thư mục ta muốn tạo git repo, lệnh sau đây sẽ tạo mới một thư mục _.git_ - chứa tất cả các config cần thíêc cho repo mới tạo đó. 
  ```
  git init
  ```

  ### <span style="color:blue"> Sao chép một Repository đã tồn tại </span>
  Sử dụng lệnh _git clone [url] để sao chép một repo đã có sẵn. Ví dụ, clone _fresherproject_vng_ ta thực hiện như sau:
  ```
  git clone https://github.com/riletan/fresherproject_vng.git
  ```
   Một thư mục fresherproject_vng sẽ được tạo ra và chứa thư mục _./git_ và bản sau mới nhất của project. Nếu muốn lưu repo này xuống một thư mục có tên khác, không phải là fresherproject_vng ta thực hiện như sau:
   ```
   git clone https://github.com/riletan/fresherproject_vng.git folder_name
   ```
  Có thể clone một git repo về  qua một số  transfer protocol khác nhau. Ví dụ, thay vì sử dụng _git://_ ta có thể sử dụng http(s):// hoặc user@server:/path.git thông qua giao thức SSH. 
  
  ### <span style="color:blue"> Các Thao tác với tập tin </span>
  * Kiểm tra trạng thái của tập tin
  ```
  git status
  ```
  * Theo dõi tập tin mới và thêm file vào staged area.
    * Thêm từng file riêng lẽ.
    ```
    git add file_name
    ```
    * Thêm tất cả các thay đổi trong **Working Directory**:
    ```
    git add .
    ```
  * Bỏ qua tập tin: Có thể tạo file _.gitignore_ liệt kê các mẫu-patterms để  git bỏ qua. Ví dụ, một file _.gitignore_ cơ bản như sau: 
  ```
    # a comment - dòng này được bỏ qua
    # không theo dõi tập tin có đuôi .a 
    *.a
    # nhưng theo dõi tập lib.a, mặc dù đang bỏ qua tất cả tập tin .a ở trên
    !lib.a
    # chỉ bỏ qua tập TODO ở thư mục gốc, chứ không phải ở các thư mục con subdir/TODO
    /TODO
    # bỏ qua tất cả tập tin trong thư mục build/
    build/
    # bỏ qua doc/notes.txt, không phải doc/server/arch.txt
    doc/*.txt
    # bỏ qua tất cả tập .txt trong thư mục doc/
    doc/**/*.txt
  ```
  * Xem chi tiết các thay đổi staged & unstaged: Câu lệnh này sẽ so sánh các thay đổi giữa **Working Directory** và **Staged Area**, trả về các giá trị đã bị thay đổi nhưng chưa được stage  
  ```
      git diff
  ```
  * Xem chi tiết những thay đổi so với lần commit trước đó:
  ```
    git diff --staged hoặc git diff --cached (trước 1.6.1)
  ```
  * Commit các thay đổi: "messages" mô tả ngắn gọn thông tin về  đợt commit. 
  ```
    git commit -m "messages"
  ```
  * Commit bỏ qua **staged area**: Không cần chạy _git add_ khi sử dụng lệnh dưới đây:
  ```
    git commit -a -m "messages"
  ```
  * Xóa tập tin
  ```
    git rm file_name
  ```
  * Di chuyển tập tin: **Git** hiểu việc này là đổi tên.
  ```
    git mv file_from file_to
  ```

  ### <span style="color:blue"> Xem lịch sử Commit </span>
  Các ví dụ dựa trên project [**simple git** ](https://github.com/schacon/simplegit-progit)
  ```
  git clone git://github.com/schacon/simplegit-progit.git
  ```
  * _$git log_ không có tham số : liệt kê các commit  được thực hiện theo thứ tự thời gian.
  * _$git log -p -n_: _-p_ hiển thị sự khác nhau giữa commit với commit trước nó. _-n_ với n là số commit mà ta muốn sẽ hiển thị giới hạng.
  * _$git log -p -word-diff_ xem lại sự thay đổi một cách tổng quát, thay vì từng dòng.
  * _$git log --stat_ xem lại lịch sử  kèm theo tóm tắt cho mỗi commit.
  ```
    commit ca82a6dff817ec66f44342007202690a93763949
    Author: Scott Chacon <schacon@gmail.com>
    Date:   Mon Mar 17 21:52:11 2008 -0700

        changed the verison number

    Rakefile | 2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)

    commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
    Author: Scott Chacon <schacon@gmail.com>
    Date:   Sat Mar 15 16:40:33 2008 -0700

        removed unnecessary test code

    lib/simplegit.rb | 5 -----
    1 file changed, 5 deletions(-)
  ```
  * _$git log --pretty=oneline_ : Làm đẹp kết quả hiện thị, có các tùy chọn là oneline, short, full, fuller. Ví dụ: 
  ```
    $git log --stat --pretty=oneline
    ca82a6dff817ec66f44342007202690a93763949 changed the verison number
    Rakefile | 2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)
    085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 removed unnecessary test code
    lib/simplegit.rb | 5 -----
    1 file changed, 5 deletions(-)
    a11bef06a3f659402fe7563abf99ad00de2209e6 first commit
    README           |  6 ++++++
    Rakefile         | 23 +++++++++++++++++++++++
    lib/simplegit.rb | 25 +++++++++++++++++++++++++
    3 files changed, 54 insertions(+)
  ```

  * _$git log --graph_ Hiển thị biểu đồ ASCII của branch và lịch sử merge cùng vài thông tin khác.
  * _$git log --pretty=format: Tự định dạng phần hiển thị. Ví dụ:
  ```
    $git log --pretty=format:"%h - %an, %ar : %s"
    ca82a6d - Scott Chacon, 10 years ago : changed the verison number
    085bb3b - Scott Chacon, 10 years ago : removed unnecessary test code
    a11bef0 - Scott Chacon, 10 years ago : first commit
  ``` 
  Ngoài ra còn nhiều định dạng khác, tham khảo thêm [Pro Git - 1st Edition (2009)](https://git-scm.com/book/en/v1/Git-Basics-Viewing-the-Commit-History)

  <span style="color=blue"> Hiển thị commit log trên giao diện đồ họa.
  * **Gitk** được xuất bản cùng với git.\
  ![alt text](/doc/figure/git5.png)\

  * **Source Tree**: Phần mềm quản lí Git bằng giao diện đồ họa miễn phí \
  ![alt text](/doc/figure/git6.png)

  ### <span style="color:blue"> Cơ bản về phục hồi </span>
  1. Thay đổi commit cuối cùng: Nếu như sau khi commit rồi mà vẫn còn file chưa commit/commit sai hay messages bị sai, ta có thể sử dụng lệnh _git commit --amend_ để chỉnh sửa lại lần commit đấy.Ví dụ:
  ```
    $ git commit -m 'initial commit'
    $ git add forgotten_file
    $ git commit --amend
  ```
  Sau khi thực hiện các lệnh trên thì vẫn chỉ có một commit, kết quả của commit cuối cùng sẽ đè lên commit ban đầu.\
  
  2. Loại bỏ tập tin đã stage. 
  ```
    git reset HEAD <file>
  ```
  3. Phục hồi các tập tin đã bị thay đổi: 
  ```
  git checkout -- <file>
  ```
   ### <span style="color:blue"> Làm việc với remotes </span>
  1. Hiển thị máy chủ 
  - _$git remote_ : hiển thị tên gắn gọn của các remotes.
  ```
    $ git remote
    origin
  ```
  - _$git remote -v_ hiển thị đầy đủ địa chỉ của remote.
  2. Thêm **remote** mới:  _git remote add [shortname] [url]_
  3. Lấy dữ liệu từ các remote về local: _git fetch [remote-name]\
    Lệnh fetch sẽ khéo tất cả dữ liệu về kho chứa local, tuy nhiên nó không tự động tích hợp với bất kỳ sự thay đổi nào.
  4. Truy xuất và tích hợp nhánh remote vào nhánh local: _git pull_
  5. Đẩy lên remote : _git push origin master_ lệnh này sẽ đẩy nhánh master vào nhánh orgin trên máy chủ.
  6. Kiểm tra remote: _git remote show origin_ lệnh này sẽ liệt kê địa chỉ của repo origin cũng như các nhánh mà nó đang theo dõi.
  7. Đổi tên nhánh remote: _git remote rename old_name new_name_ 
  8. Xóa nhánh remote: _git remote rm brand-name_

### <span style="color:blue"> Tags </span>
Dùng để  đánh dấu các thời điểm, các phiên bản phát hành. 
1. Liệt kê các tag:  _git tag_  Lệnh này sẽ liệt kê các tag theo thứ tự bảng chữ cái. Có thể  filter khi liệt kê các tag. Ví dụ, ta chỉ quan tâm tới các tag thuộc dải 1.4.2
```
  $ git tag -l 'v1.4.2.*'
  v1.4.2.1
  v1.4.2.2
  v1.4.2.3
  v1.4.2.4 
```
2. Thêm một tag mới:\ 
  Git sử dụng hai loại tag chính: lightweight và anotated
  * Lightweight tag (tag nhẹ) giống như một nhánh mà không có sự thay đổi - nó chỉ trỏ đến một commit nào đó.
  ```
    git tag v1.4-lw
  ```
  * Anotated tag (Tag Chú tích) là đối tượng đầy đủ được lưu trữ trong csdl của Git. Nó được băm, chứa tên người tag, địa chỉ email, ngày tháng, có thông điệp kèm theo và có thể được ký bằng xác thực GNU Privacy Guard (GPG). Tạo anotated tag:
  ```
    $ git tag -a v1.4 -m 'my version 1.4'
  ```
   Xem thông tin của tag cùng với commit được tag: 
  ```
    $ git show
  ```
Thêm signed tag: Giả sử ta có một private key, ta có thể  ký các tác sử dụng GPG như sau
```
git tag -s v1.5 -m 'my signed 1.5 tag'
```
3. Xác thực các tag: _git tag -v [tên-tag]_Lệnh này sử dụng GPG để xác minh chữ ký, cần phải có public key của người ký để có thể thực hiện được điều này.
4. Tag muộn: Có thể tag các commit đã thực hiện trước đó, chỉ cần chỉ định mã băm của commit(hoặc một phần của nó) ở cuối lệnh:
 ```
 $ git tag -a v1.2 -m 'version 1.2' 9fceb02
 ```

 5. Chia sẻ các tag.\
  Mặc định _git push_ không truyền các tag lên remote. Ta phải đẩy thủ công bằng lệnh:
  ```
    $ git push origin [tên-tag]
  ```
  Nếu muốn đẩy nhiều tag lên cùng một lúc, sử dụng tham số  --tags, nó sẽ đẩy tất cả các tag chưa được đồng bộ lên remote.
  ```
    $ git push origin --tags
  ```





 







