# <span style="color:red"> Gitlab </span>
Nguồn: [hoclaptrinh.vn](https://hoclaptrinh.vn) ; [viblo.asia](https://viblo.asia/p/tim-hieu-kien-truc-gitlab-BAQ3vVbZvbOr) ; [itjobs.com](http://www.itjobs.com.vn/vi/article/gitlab-gioi-thieu-tinh-nang-kiem-thu-ung-dung-moi-2386)
![alt text](/doc/figure/gitlab.jpg)
## <span style="color:blue"> Định ngĩa </span>

- Gitlab là hệ thống self-hosted cung cấp dịch vụ lưu trữ mã nguồn nền web sử dụng hệ thống kiểm soát Git revision tương tự như Bitbucket hay Github.
- GitLab là một dự án mã nguồn mở, được rất nhiều người hỗ trợ phát triển trên toàn cầu. 
- Gitlab được thành lập bởi Dmitriy Zaporozhets năm 2013, được viết bằng Ruby với giấy phép mã nguồn mở MIT.

## <span style="color:blue"> Các phiên bản gitlab </span>
* **GitLab.com** : Phiên bản cung cấp dịch vụ lưu trữ nền web sử dụng máy chủ của GitLab được dùng cho các mã nguồn lập trình và phát triển những dự án lập trình có sử dụng hệ thống kiểm soát Git revision tương tự như Bitbucket hay Github.
* **GitLab Community Edition (CE)** : Là phiên bản mã nguồn mở sử dụng máy chủ của bạn, được hỗ trợ bởi cộng đồng cùng phát triển
* **Gitlad enterprise edition (EE)** : Phiên bản doanh nghiệp sử dụng máy chủ riêng của doanh nghiệp nhưng được GitLab hỗ trợ cài đặt, sửa lỗi ...
* **GitLab Continuous Integration (CI)** : Phiên bản GitLab CE/EE nhưng được cung cấp trên máy chủ của GitLab.
## <span style="color:blue"> Các tính năng của git lab </span>
- Cho phép cài đặt trên máy chủ riêng.
- Gitlab tạo ra **protected branches** để cấp quyền cho những người được phép commit và pushing code.
    * Ngăn chặn việc push từ tất cả mọi người trừ user và master.
    * Ngăn chặn việc push code lên branch từ những người không có quyền truy cập
    * Ngăn chặn bất kỳ ai thực hiện xóa branch
    * Có thể tạo bất kỳ branch từ một protected branch. Mặc định, master branch là protected branch.
    * Để bảo mật một branch, user cần có ít nhất một quyền cho phép từ master branch.
- Review Apps (Từ gitlab 8.14) cho phép kiểm thử và demo tính năng mới.
- Quản lý users, groups, permissions: Có 5 mức user permissions là Guest, Reporter, Developer, Maintainer, Owner. Chi tiết xem thêm ở [https://docs.gitlab.com](https://docs.gitlab.com/ee/user/permissions.html)
- Continuous Integration (CI), Continuous Deployment (CD) 
- Quản lý project visibility: có 3 kiểu project: Private, Internal, và Public.
## <span style="color:blue"> Kiến trúc của Gitlab </span>
![alt text](/doc/figure/gitlab2.png)