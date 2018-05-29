# Nagios
Nagios Core is open source software licensed under the GNU GPL V2.

Currently it provides:

* Monitoring of network services (SMTP, POP3, HTTP, NNTP, ICMP, SNMP, FTP, SSH)
* Monitoring of host resources (processor load, disk usage, system logs) on a majority of network operating systems, including Microsoft Windows, using monitoring agents.
* Monitoring of any hardware (like probes for temperature, alarms, etc.) which have the ability to send collected data via a network to specifically written plugins
* Monitoring via remotely run scripts via Nagios Remote Plugin Executor
* Remote monitoring supported through SSH or SSL encrypted tunnels.
* A simple plugin design that allows users to easily develop their own service checks depending on needs, by using their tools of choice (shell scripts, C++, Perl, Ruby, Python, PHP, C#, etc.)
* Available data graphing plugins
* Parallelized service checks
* Flat-text formatted configuration files (integrates with many config editors)
* The ability to define network host using 'parent' hosts, allowing the detection of and distinction between hosts that are down or unreachable
* Contact notifications when service or host problems occur and get resolved (via e-mail, pager, SMS, or any user-defined method through plugin system)
* The ability to define event handlers to be run during service or host events for proactive problem resolution
* Automatic log file rotation
* Support for implementing redundant monitoring hosts
* Support for implementing performance data graphing
* Support for database backend (such as NDOUtils)
* An web-interface for viewing current network status, notifications, problem history, log files, etc.

# Check_mk 
## Overview
Check_MK is an extension to the Nagios monitoring system that allows creating rule-based configuration using Python and offloading work from the Nagios core to make it scale better, allowing more systems to be monitored from a single Nagios server.

It comes with a set of system checks, a mod_python and JavaScript based web user interface, and a module that allows fast access to the Nagios core. On top of Nagios it also adds additional features.

## Technology

Check_MK includes a combination of multiple components:

* Using multiple "passive" checks via a single "active" check (passive checks are only processed, but not executed by Nagios, which is considerably faster[citation needed])
* Modules to unify configuration handling and connections to monitored systems. This makes TCP or SNMP access transparent to the user and authors of check plugins
* Configuration handling for PNP4Nagios, a graphing tool for Nagios and compatible systems
* An agent for host operating systems. The relatively small agent only runs the commands to gather the data needed to run checks but avoids local processing. Per design it is also not allowed to accept any external input. There are agents for different operating systems such as Linux, Unix, Windows and OpenVMS. The agents are made to be modifyable and/or extensible by the user.
* Checks that consist of agent-side and server-side parts. Check_MK gives them a framework for handling connections, talking to Nagios and handling internal errors. There are rather strict design standards for writing checks that are supposed to bring more conformity to the plugins than with standard Nagios plugins. The checks handle the detection of supported devices and are then automatically called to check against the expected status (good) of a component that was found earlier on. Currently there are about 640 plugins in the official distribution, plus 100 on the community exchange. A larger number of checks can be found at Github.
* Livestatus is a module that handles direct access to the core of Nagios to allow. It can be queried using a query language and is used as a backend. Nagios addons that use livestatus to access Nagios data include JasperReports, NagiosBP, Thruk, NagstaMon, NagVis and Multisite.
* Multisite is a GUI component that can run in parallel or instead of the standard Nagios GUI. It uses Livestatus to access one or more Nagios servers directly and can build reports from the available data.
#### There also are plugins for Multisite:
* Check_MK BI - a business process / impact analysis tool (rule-based, if you define a rule for "all servers" and you add a new server, the rule immediately applies to that server, too.)
* WATO - a web administration frontend to the check_mk (and nagios) configuration (rule-based)
* Event Console - a rule based event processing interface to handle i.e. data arriving from SNMP Traps or Syslog. This data can be processed further by applying rules ("if this message occurred more than 5 times this hour, then...") and finally also turned into services monitored by Nagios. It's not primarily a browser for unstructured logs, but being similar to event processing in classic NMS.

It is possible to use some of the components on their own. Check_MK can be used to define a configuration that only consists of standard Nagios checks. Another option is to add livestatus to an existing Nagios server without any further modifications. That way a user can use the newer Web interfaces like Multisite or Thruk. There's also a livestatus-based tool to replace NSCA, transferring both status information and valid Nagios configuration to a remote server (With normal NSCA, the handling of remote configuration can be complex).

### Differences from standard Nagios installations
* Higher total number of services checks as one service is generated per monitored component - a server can have over 1000 services which are all monitored (and can be grouped)
* Usage of RRD databases for historical data with almost every service, set up and displayed automatically based on the check and validity of data.
* Standard check interval of 1 minute (Nagios defaults to 5 minutes)
* In SNMP monitoring, avoidance of traps in favour of status polling (for extra performance data)
* Smaller, fully scriptable configuration
* Rare use of high-maintenance Nagios config "tricks"
* Focus on passive services solves Nagios check latency problems.
* No use of databases, commonly used data is held in RAM or fetched as live data from Nagios
* Always preferring a rule-based configuration (my most important disks should be no fuller than 90%, and anything else can be up to 95%) over explicit (this disk here and this disk there) configuration statements.
* Scalability (users connect 100 nagios servers into one UI (source: list archive))

#### Source: Wiki
