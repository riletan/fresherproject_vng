# Haproxy & Keepalived Installation tutorial

Có thể cài đặt keepalived và haproxy từ base repository của centos/unbuntu, tuy nhiên các verison này không phải là phiên bản mới nhất & không thể  custom configure.
## Overview
* Network: Nat & Internal Network/ Host Only
* Gateway : 2 server Centos. 2 Interface. Service: Haproxy, Keepalived:  cân bằng tải và high availability.
* Application: 2 server Ubuntu. 1 Interface private. Service: Apache: web service hiển thị nội dung

![alt text](/doc/figure/system_overview.png)

## Haproxy
* Load balancer (LB) Cân Bằng Tải là việc phân bố đồng đều lưu lượng truy cập giữa hai hay nhiều các máy chủ có cùng chức năng trong cùng một hệ thống.
* LB là 1 trong những thành phần quan trọng nhất của hệ thống monitor.
* LB là vị trí duy nhất giúp người quản trị nhìn được các service phía sau chúng.

### Install
1. Tải về  Haproxy bản mới nhất: [haproxy-18.9.tar.gz](http://www.haproxy.org/download/1.8/src/haproxy-1.8.9.tar.gz)
2. Giải nén source vừa tải về
3. Chuyển work directory tới thư mục haproxy-1.8.9
```
wget "http://www.haproxy.org/download/1.8/src/haproxy-1.8.9.tar.gz"
tar xzf haproxy-1.4.24.tar.gz
cd haproxy-1.4.24
```
4. Chuẩn bị build enviroment
```
sudo yum install gcc pcre-static pcre-devel -y

```
5. Complie & cài đặt Haproxy, mặt dịnh Haproxy sẽ được cài đặt dưới /usr/local/haproxy
```
sudo make TARGET=linux2628
sudo make install
```
6. Config cho haproxy khởi động cùng hệ thống:
```
sudo cp ~/haproxy-1.7.8/examples/haproxy.init /etc/init.d/haproxy
sudo chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload
sudo chkconfig haproxy on

```
7. Kiểm tra xem Haproxy đã cài đặt thành công hay chưa
```
haproxy -v
```
Nếu không có gì bất thường, terminal sẽ hiện thị version của Haproxy như sau: 
```

```
8. Config firewall trên centos 7 cho phép haproxy hoạt động
```
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-port=8181/tcp
sudo firewall-cmd --reload
```
### Configure
LOAD LAYER 4
Tạo file haproxy.cfg dưới /etc/haproxy/haproxy.cfg
```
sudo nano /etc/haproxy/haproxy.cfg
```
Hệ thống có config như sau:
```
global
   log 127.0.0.1 local0 notice 
   chroot /var/lib/haproxy
   stats timeout 30s
   user haproxy
   group haproxy
   daemon
   stats socket /var/run/haproxy.stat mode 660 level admin  #mở socket phục vụ cho check_mk plugin

defaults
   log global
   mode http
   option httplog
   option dontlognull
   timeout connect 5000
   timeout client 50000
   timeout server 50000

frontend http_front
   bind 192.168.56.10:80
   mode http
   default_backend app

backend app # Hai server backend
   balance roundrobin
   server app1 10.0.2.4:80 check
   server app2 10.0.2.9:80 check


listen stats
   bind 192.168.56.11:80
   stats enable
   stats uri /stats
   stats realm Haproxy\ Statistics
   stats auth admin:admin
   server monitor 10.0.2.12:80 check #server monitor
```

### Configure Log

1. Chỉnh sửa rsyslog config
```
sudo nano /etc/rsyslog.conf
```
Edit file config như sau: 
```
$ModLoad imudp
$UDPServerAddress 127.0.0.1
$UDPServerRun 514
```
Bây giờ rsyslog sẽ hoạt động ở địa chỉ 127.0.0.1(localhost)/port 514  nhưng messages sẽ được lưu ở /var/log/syslog

2. Tách log haproxy: /var/log/haproxy.log
```
nano /etc/rsyslog.d/haproxy.conf
```
Thêm vào nội dung của file haproxy.conf như sau:
```
if ($programname == 'haproxy') then -/var/log/haproxy.log
```
Restart rsyslog
```
service rsyslog restart
```
Như vậy, tất cả các log của haproxy đã được chuyển hướng về file /var/log/haproxy.log


## Keepalived

### Install
1. Tải về phiên bản mới nhất: [keepalived-1.4.4](http://keepalived.org/software/keepalived-1.4.4.tar.gz) 
```
wget http://keepalived.org/software/keepalived-1.4.4.tar.gz
tar xzf keepalived-1.4.4.tar.gz
cd keepalived-1.4.4
```
2. Chuẩn bị môi trường build (centos)
```
sudo yum install curl gcc openssl-devel libnl3-devel net-snmp-devel
```
3. Build & Install
```
/configure --prefix=/usr/local/keepalived-1.4.4
make
sudo make install
```
4. Khởi tạo init script để  điều khiển keepalived daemon
```
ln -s /etc/rc.d/init.d/keepalived.init /etc/rc.d/rc3.d/S99keepalived
```
5. Config cho keepalived khởi động cùng hệ thống:
```
sudo chkconfig keepalived on
```
6. Xem log của keepalived
```
sudo cat /var/log/messages | grep Keepalived
```
```
```
### Configure
```
sudo nano /etc/keepalived/keepalived.conf
```
File configure có nội dung như sau: 
```
! Configuration File for keepalived

global_defs {
   notification_email {
     tanri.lee@gmail.com
   }
   notification_email_from 1512772@hcmut.edu.vn
   smtp_server localhost
   smtp_connect_timeout 30
   router_id LVS_DEVEL
   vrrp_skip_check_adv_addr
   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}
vrrp_script chk_haproxy {
 script "/etc/keepalived/health_check_haproxy.sh" #health check haproxy
 interval 2 #2s #Dinh ki`.
 weight 4 # 
}
vrrp_instance VI_1 {
    state MASTER
    interface enp0s8
    virtual_router_id 51 #Phan biet cac router ao.
    priority 100 #Cao nhat se tro nam MASTER, 1->254
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        192.168.56.10 #Vip
        192.168.56.11
    }
    track_script {
        chk_haproxy
    }
}

```
Tạo script health_check_haproxy.sh có nội dung như sau: 
```
_isRunning() {
         ps -o comm= -C "$1" 2>/dev/null | grep -x "$1" >/dev/null 2>&1

}

if _isRunning haproxy; then
    exit 0
else
    exit 1
fi
```

Mặt định SELinux ngăn custom script thực thi một cách tự động,  ta sẽ thêm ngoại lệ cho script như sau: 
```
chcon -t keepalived_unconfined_script_exec_t /etc/keepalived/heath_check_haproxy.sh
```

Nếu như không thể restart haproxy thì thêm dòng sau vào cuối file /etc/sysctl.conf
```
net.ipv4.ip_nonlocal_bind=1
```
Sau đó thực thi lệnh sau: 
```
sysctl -p
```
Restảrt Haproxy

### Confiure Firewall

Mặc định các gói tin multicast sẽ bị chặn bở firewall trên centos 7 vì vậy ta cần phải configure firewall cho phép các gói tin đi qua.

```
firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" destination address="224.0.0.18" protocol value="ip" accept' --permanent
firewall-cmd --reload
```





