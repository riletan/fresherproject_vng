# Configure Postfix to Send Mail Using Gmail and Google Apps on Debian or Ubuntu
### Nguồn:  Linode Community
#### Install postfix
1. Cài đặt *Postfix* and the *libsasl2-modules* package:
```
sudo gpt-get update
sudo apt-get install libsasl2-modules postfix
```
2. Hộp thoại General type of mail configuration hiện ra, chọn _Internet Site_

![alt text](/doc/figure/postfix1.png)

3. Điền tên domain: 

![alt text](/doc/figure/postfix2.png)

#### Tạo App password cho postfix
1. Bật tính năng xác thực 2 lớp cho tài khoải gmail.
Login vào gmail, click vào link [Manage your account access and security settings](https://myaccount.google.com/security), chọn _2-Step Verification_. Làm theo các hướng dẫn trên màn hình để bật xác thực hai lớp.
2. Click vào link [Generate an App password](https://security.google.com/settings/security/apppasswords) để tạo mật khẩu cho Postfix:

![alt text](/doc/figure/postfix3.png)

 Click _Select app_, chọn _Other (custom name)_. Nhập  _“Postfix”_ và  click _Generate_.

3. Mật khẩu app sẽ được sinh ra. Lưu lại mật khẩu ở đâu đó an toàn chút rồi click done. 

![alt text](/doc/figure/postfix4.png)

4. Config postfix để gửi email với tài khoản & password vừa tạo 
* Tạo ra file _/etc/postfix/sasl/sasl_passwd_, dán vào nội dung dưới đây. thay_username & password là của gmail vừa tạo app password.
```
[smtp.gmail.com]:587 username@gmail.com:password
```
* Tạo file hash db  cho Postfix
```
sudo postmap /etc/postfix/sasl/sasl_passwd
```
Nếu mọi thứ OK sẽ xuất hiện _/etc/postfix/sasl/sasl_passwd.db_
* Để an toàn hơn, ta sẽ set lại quyền của 2 file sasl_passwd và sasl_passwd.db sao cho chỉ root user mới được đọc ghi thôi.
```
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```
#### Configure the Postfix Relay Server
1. Tìm và thay đổi _relayhost trong file /etc/postfix/main.cf
```
relayhost = [smtp.gmail.com]:587
```
2. thêm các dòng sao vào cuối file cf
```
# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```
3. Lưu lại và restart postfix.
#### Enable “Less secure apps” access
Nếu như bị gmail block connection thì ta phải enable ["Less secure apps"](https://www.google.com/settings/security/lesssecureapps) access

![alt text](/doc/figure/postfix5.png)

#### Test Postfix 

```
sendmail ahihi@gmail.com
From: you@example.com
Subject: Test mail
This is a test email
.
```
Kiểm tra coi có nhận được email chưa, nếu nhận được rồi thì ok. Xem thêm syslog để biết thêm chi tiết 
```
sudo tail -f /var/log/syslog
```