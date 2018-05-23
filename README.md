# fresherproject_vng
Load Balancing + High Availability:  <br />
    Haproxy + Keepalived

Monitor system: <br />
    nagios core + check_mk raw + pnp4 nagios 


Reference: 
    #Public IP <br />
    VIP1(Web app):      192.168.56.10 <br />
    VIP2(Monitor app):  192.168.56.11 <br />
    #Privite IP <br />
    centos.gateway.master:  10.0.2.11 <br />
    centos.gateway.backup:  10.0.2.13 <br />
    # <br />
    ubuntu.application.1:   10.0.2.4 <br />
    ubuntu.application.2:   10.0.2.9 <br />
    ubutnu.motitor:         10.0.2.12 <br />

Authentication: <br />
    stats:      admin:admin <br />
    nagios:     admin:admin <br />
    check_mk:   cmkadmin:tanri<br />       

