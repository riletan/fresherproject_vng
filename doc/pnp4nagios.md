# Pnp4Nagios

Trong quá trình sử dụng Nagios, các dữ liệu thu thập được chưa được hiển thị dưới dạng đồ thị để tiện cho việc theo dõi, thống kê. Vì vậy, đối với các hệ thống quy mô giám sát nhiều và lớn, việc đồ thị hóa các dữ liệu thu thập được trong Nagios là rất cần thiết và tối ưu trong việc theo dõi, giám sát hệ thống -> Pnp4Nagios

## Install
1. Tải về source code pnp4angios: [pnp4nagios-0.6.26.tar.gz](https://nchc.dl.sourceforge.net/project/pnp4nagios/PNP-0.6/pnp4nagios-0.6.26.tar.gz)
```
wget https://nchc.dl.sourceforge.net/project/pnp4nagios/PNP-0.6/pnp4nagios-0.6.26.tar.gz
tar zxvf pnp4nagios-0.6.26.tar.gz
cd pnp4nagios-0.6.26

```
2. Build và Install
```
./configure
make all && make fullinstall
```
3. Khởi chạy service
```
chkconfig -–add npcd && chkconfig -–level 35 npcd on
systemctl restart apache2
```
4. Nếu không có vấn đề gì, ta xoá page default pnp4nagios đi
```
mv /usr/local/pnp4nagios/share/install.php /usr/local/pnp4nagios/share/install.php.ORI
```
## Config nagios 

1. Sao chép nội dung dưới đây vào _usr/local/nagios/etc/nagios.cfg_
```
# definitions for PNP in nagios.cfg (icinga.cfg)
# please make sure that you don't have duplicate entries
#
# Synchronous mode
#
process_performance_data=1

enable_environment_macros=1 # available since Nagios 3.x

service_perfdata_command=process-service-perfdata

host_perfdata_command=process-host-perfdata # NOT advisable prior to Nagios 3.0

# Bulk / NPCD mode
#
process_performance_data=1
# *** the template definition differs from the one in the original nagios.cfg
#
service_perfdata_file=/usr/local/pnp4nagios/var/service-perfdata
service_perfdata_file_template=DATATYPE::SERVICEPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tSERVICEDESC::$SERVICEDESC$\tSERVICEPERFDATA::$SERVICEPERFDATA$\tSERVICECHECKCOMMAND::$SERVICECHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$\tSERVICESTATE::$SERVICESTATE$\tSERVICESTATETYPE::$SERVICESTATETYPE$
service_perfdata_file_mode=a
service_perfdata_file_processing_interval=15
service_perfdata_file_processing_command=process-service-perfdata-file
# *** the template definition differs from the one in the original nagios.cfg
#
host_perfdata_file=/usr/local/pnp4nagios/var/host-perfdata
host_perfdata_file_template=DATATYPE::HOSTPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tHOSTPERFDATA::$HOSTPERFDATA$\tHOSTCHECKCOMMAND::$HOSTCHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$
host_perfdata_file_mode=a
host_perfdata_file_processing_interval=15
host_perfdata_file_processing_command=process-host-perfdata-file
```
2. Thêm vào file command dưới _/usr/local/nagios/etc/objects/commands.cfg_ 2 command thực thi perfdata cho host và service như dưới đây: 
```
# Bulk with NPCD mode
#
define command {
command_name process-service-perfdata-file
command_line /bin/mv /usr/local/pnp4nagios/var/service-perfdata /usr/local/pnp4nagios/var/spool/service-perfdata.$TIMET$
}
define command {
command_name process-host-perfdata-file
command_line /bin/mv /usr/local/pnp4nagios/var/host-perfdata /usr/local/pnp4nagios/var/spool/host-perfdata.$TIMET$
}
```
3. Khai báo 2 template mới cho việc hiển thị pnp4nagios trong _/usr/local/nagios/etc/objects/templates.cfg_
```
define host {
name host-pnp
action_url /pnp4nagios/index.php/graph?host=$HOSTNAME$&srv=_HOST_’ class=’tips’ rel=’/pnp4nagios/index.php/popup?host=$HOSTNAME$&srv=_HOST_
register 0
}
define service {
name srv-pnp
action_url /pnp4nagios/index.php/graph?host=$HOSTNAME$&srv=$SERVICEDESC$’ class=’tips’ rel=’/pnp4nagios/index.php/popup?host=$HOSTNAME$&srv=$SERVICEDESC$
register 0
}
```
4. Config các server mà ta muốn vẽ đồ thị lên: (Ví dụ: _/usr/local/nagios/etc/objects/localhost.cfg_), thêm host-pnp đối với host và srv-pnp đối với service. File cofig sẽ có nội dung tương tự như sau: 
```
define host{
use linux-server,host-pnp ; Name of host template to use
host_name localhost
alias localhost
address 127.0.0.1
}
define hostgroup{
hostgroup_name linux-servers ; The name of the hostgroup
alias Linux Servers ; Long name of the group
members localhost ; Comma separated list of hosts that belong to this group
}
define service{
use local-service,srv-pnp ; Name of service template to use
host_name localhost
service_description PING
check_command check_ping!100.0,20%!500.0,60%
}
```
5. Config pnp4nagios popups
```
cd pnp4nagios-0.6.25
cp contrib/ssi/status-header.ssi /usr/local/nagios/share/ssi/
```
6. Restart nagios & apace2
```
systemctl restart npcd nagios httpd
```