# Apache, Nagios, Check_mk, pnp4Nagios Installation Tutorial
## Apache
```
sudo apt update
sudo apt install apache2
```
## Nagios
### Install 
1. Cài đặt các thư viện cần có cho nagios
```
apt-get udpate
apt-get -y install build-essential apache2 php openssl perl make php-gd libgd2-xpm-dev libapache2-mod-php libperl-dev libssl-dev daemon wget apache2-utils unzip
```
2. Tải về nagios mới nhất: [nagios-4.3.4.tar.gz](https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.4.tar.gz)
```
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.4.tar.gz
tar -xzf nagios*.tar.gz
cd nagios-4.3.4
```
3. Tạo user nagios và usergroup nagios
```
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagios,nagcmd www-data
``` 
4. Configure, Complie & Install Nagios
Configure nagios với group nagios
```
./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/
```
Complie và install nagios
```
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf
``` 
5. Install nagios plugins
Tải về nagios plugins : [nagios-plugins-2.1.2.tar.gz](https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz)
```
wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar -xzf nagios-plugins*.tar.gz
cd nagios-plugin-2.2.1/
```
Complie và cài đặt: 
```
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make
make install
```
### Config nagios 
1. Update mail trong file */usr/local/nagios/etc/objects/contacts.cfg*
2. Configure web interface
* Tạo tài khoản nagiosadmin để đăng nhập vào nagos web interface 
```
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
```
* Enable CGI:
```
a2enmod cgi
```
* Restart Apache2
```
service apache2 restart
```
* Verify nagios configuration file
```
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
```
* Start nagios 
/etc/init.d/nagios start
* Enable khởi động cùng hệ thống
```
systemctl enable nagios
```
* Config firewall 
```
ufw allow 80/tcp
ufw reload
ufw enable
```
* Truy cập: *http://ip_address/nagios* 
### Monitor các host khác trong hệ thống 




