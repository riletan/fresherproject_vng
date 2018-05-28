# Apache, Nagios, Check_mk, pnp4Nagios Installation Tutorial
## Apache
```
sudo apt update
sudo apt install apache2
```
## Nagios
### Install 
1. Cài đặt build environment
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
#### Trên remote host
1. Cài đặt NRPE app-on và Nagios plugins
* Centos 7/RHEL 7
```
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y nrpe nagios-plugins-all
```
* Ubuntu 16.04/ Debian 9
```
apt-get install -y nagios-nrpe-server nagios-plugins
```
2. Configure NRPE App-on
* Mở file *etc/nagios/nrpe.cfg*
```
nano etc/nagios/nrpe.cfg 
```
* Thêm vào Ip server monitor như dưới đây:
```
allowed_hosts=127.0.0.1,10.0.2.12
```
3. Configure Nagios Checks:
* File config: */etc/nagios/nrpe.cfg* chứa một vài check cơ bản các thông số  về  CPU, Memory, Disk,... 
* Trên Centos7/RHEL 7:
```
command[check_users]=/usr/lib64/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_root]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -p /dev/mapper/centos-root
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[check_total_procs]=/usr/lib64/nagios/plugins/check_procs -w 150 -c 200
```
* Trên ubuntu 16.04/ Debian 9
```
command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_root]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/mapper/server--vg-root
command[check_swap]=/usr/lib/nagios/plugins/check_swap -w 20% -c 10%
command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200
```
* Trên các command ở trên: -w tượng trưng cho warning, -c là critical. 
4. Restart NRPE 
* Trên Centos 7/ RHEL 7
```
systemctl start nrpe
systemctl enable nrpe
```
Ubuntu 16.04/ Debian 9
```
/etc/init.d/nagios-nrpe-server restart
```
#### Trên server host
1. Cài đặt check nrpe plugin
```
apt-get -y install nagios-nrpe-plugin
```
2. Configure nagios để  load các file *.cfg dưới */usr/local/nagios/etc/servers* 
```
nano usr/local/nagios/etc/nagios.cfg
```
Uncomment dòng dưới đây:
```
cfg_dir=/usr/local/nagios/etc/servers
```
Tạo thư mục *servers*
```
mkdir /usr/local/nagios/etc/servers
```
3. Configure Nagios server:
```
nano /usr/local/nagios/etc/objects/commands.cfg
```
* Thêm vào comment dưới đây:
```
# .check_nrpe. command definition
define command{
command_name check_nrpe
command_line /usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -t 30 -c $ARG1$
}
```
* Tạo configuration file cho mỗi client cần monitor và lưu dưới */usr/local/nagios/etc/servers/*, dưới đây là configure cho server gateway  centos.gateway.master.cfg
```
define host{

            use                     linux-server,host-pnp
            
            host_name               centos.gateway.master
            
            alias                   centos.gateway.master
            
            address                 10.0.2.11

}


define service{

            use                             local-service,srv-pnp
            
            host_name                       centos.gateway.master
            
            service_description             Current Users
            
            check_command                   check_nrpe!check_users

}

define service{

            use                             local-service,srv-pnp
            
            host_name                       centos.gateway.master
            
            service_description             Total Processes
            
            check_command                   check_nrpe!check_total_procs

}

define service{

            use                             local-service,srv-pnp
            
            host_name                       centos.gateway.master
            
            service_description             Current Load
            
            check_command                   check_nrpe!check_load

}

```
Tiếp theo ta tạo các configuration file tương tự cho các client khác.
* Kiểm tra xem file config có bị lỗi gì hay không: 
```
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
```
* Nếu tất cả bình thường, restart nagios
```
systemctl restart nagios
```
4. Configiure Firewall
* Trên centos 7/ RHEL 7
```
firewall-cmd --permanent --add-port=5666/tcp
firewall-cmd --reload
```
* Trên ubuntu 16.04/ Debian 9
```
ufw allow 5666/tcp
ufw reload
ufw enable
```

##Check_mk
###Install


