# Fresher Project VNG

Load Balancing + High Availability:
```
Haproxy + Keepalived
```
Monitor system:
```
nagios core + check_mk raw + pnp4 nagios 
```
Mail client:
```
    postfix + gmail
```
### Reference
```
Public IP
VIP1(Web app):      192.168.56.10
VIP2(Monitor app):  192.168.56.11
```
```
Privite IP
centos.gateway.master:  10.0.2.11
centos.gateway.backup:  10.0.2.13
ubuntu.application.1:   10.0.2.4
ubuntu.application.2:   10.0.2.9
ubutnu.motitor:         10.0.2.12
```
###  Authentication


* stats:      admin:admin
* nagios:     admin:admin
* check_mk:   cmkadmin
### Authors
* riletan
