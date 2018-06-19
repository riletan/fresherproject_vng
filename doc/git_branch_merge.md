# <span style="color:red"> Phân nhánh trong Git </span>
Phân nhánh có nghĩa là phân tách ra từ luồng phát triển chính và tiếp tục làm việc mà không sợ ảnh hưởng tới luồng chính. \
Các đặc điểm khiến Branch của Git vượt trội so với các VCS khác:
* Việc Git phân nhánh diễn ra rất nhẹ nhàng và nhanh chóng. Các hoạt động tạo ra nhánh mới xảy ra gần như ngay lập tức và việc di chuyển qua lại giữ các nhánh cũng rất nhanh:
* Git khuyến khích sử dụng rẽ nhánh  và tích hợp thường xuyên vào workflow.

## <span style="color:blue"> Nhánh là gì? </span>

1. Định nghĩa:
    - Nhánh- Branch trong Git là một con trỏ có khả năng di chuyển được trỏ đến một trong những commit.
    - Một nhánh Git rất đơn giản: chứa một mã băm SHA-1 40 ký tự của commit mà nó trỏ tới. Tạo mới một branch tương đương với việc ghi 41bytes vào một tập tin nên việc tạo mới hay hủy đi nhánh rất đơn giản.
    - Tên nhánh mặt định của Git là master. 
    - Mỗi lần commit được thực hiện, nó sẽ được tự động thêm vào theo hướng tiến lên (move forward).

![alt text](/doc/figure/git7.png)

2. Tạo ra nhánh mới:
    ```
    git branch testing
    ``` 
    - Lệnh trên sẽ tạo ra một con trỏ mới, cùng trỏ tới commit mới nhất hiện tại.
    - Git sử dụng một con trỏ HEAD trỏ tới nhánh đang làm việc, lệnh _branch_ tạo ra nhánh mới nhưng không tự động chuyển sang nhánh đó.\
![alt text](/doc/figure/git8.png) 

    - Sử dụng _git checkout brand_name_ để chuyển nhánh. 
    - Sau khi chuyển sang nhánh testing, thực hiện thêm một vài commit ta có kết quả như minh họa sau: \
![alt text](/doc/figure/git10.png)

    - Chuyển lại nhánh master, thực hiện thêm một vài commit nữa, ta có kết quả như sau:\
    ![alt text](/doc/figure/git9.png)

3. Tạo nhánh mới và đồng thời chuyển sang nhánh đó: 
```
    $ git checkout -b hotfix
```
![alt text](/doc/figure/git11.png)

4. Quay về  nhánh master và tích hợp nhánh đó về  nhánh master
```
    $ git checkout master
    $ git merge hotfix
    Updating f42c576..3a0874c
    Fast forward
    README |    1 -
    1 files changed, 0 insertions(+), 1 deletions(-)
```

"Fast Forward": Khi ta merge một commit với một commit khác mà có thể truy cập được từ lịch sử của commit trước thì Git sẽ đơn giản hóa bằng cách di chuyển con trỏ về phía trước. 

![alt text](/doc/figure/git12.png)

Một trường hợp merge phức tạp hơn:\
Ta muốn tích hợp nhánh iss53 vào nhánh master, Git sẽ tiến hành như mô tả dưới đây:

![alt text](/doc/figure/git13.png)

Trong trường hợp này, Git thực hiện một tích hợp 3 chiều, sử dụng hai snapshot đầu mút của nhánh và cha chung của cả hai tạo ra một snapshot mới và cũng tự tạo ra một commit mới trỏ tới nó. Commit được gọi là merge commit và có nhiều hơn một cha (2- trong trường hợp này). 

![alt text](/doc/figure/git14.png)


5. Xóa một branch:
```
 $ git branch -d branch-name
```
6. Mâu thuẫn khi merge.
    Đôi khi việc tích hợp diễn ra không suông sẻ (ví dụ: hai nhánh có thay đổi trên cùng một file) thì những mâu thuẫn đó cần phải được giải quyết bằng tay hoặc sử dụng các tools giải quyết xung đột trước khi việc tích hợp diễn ra thành công.
7. Lệnh quảnh lí nhánh:
    - _git branch_ : liệt kê danh sách tất cả các nhánh hiện tại
    - _git branch -v_ : liệt kê các nhánh hiện tại cùng commit mới nhất trên từng nhánh.
    - _git branch --merged hoặc git branch --no-merged: liệt kê các nhánh đã được/ chưa được merge vào nhánh hiện tại.
    - _git branch -d_: Khi xóa các branch chưa được merge vào nhánh hiện tại bằng lệnh này thì hệ thống sẽ báo lỗi và không cho xóa. Nếu thực sự muốn xóa & chấp nhận mất đi các thay đổi thì dùng tham số _-D_
    




