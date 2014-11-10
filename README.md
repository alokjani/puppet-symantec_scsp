# puppet-symantec_scsp

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it it useful](#module-description)
3. [Setup - The basics of getting started](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - module internals](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)

##Overview
The symantec_scsp module allows you to manage the Symantec™ Critical System Protection installs on Windows.

##Module Description

The symantec_scsp module installs the SCSP agent from a local copy of the installer and an SSL certificate file. 

##Setup

This module has no external dependencies. It consists of a single class.
Parameters need to be specified as such : 

```puppet
  class { symantec_scsp :
#   ensure                  => absent,
    installer               => 'Z:\installers\HIPS_Windows\agent.exe',
    management_server       =>  '1.1.1.1',
    alt_management_servers  =>  '2.2.2.2',
    agent_port              =>  443,
    ssl_cert_file           =>  'Z:\installers\HIPS_Windows\agent-cert.ssl',
    ids_policy_group        =>  'Windows',
    install_log             =>  'c:\SCSP_install.log',
  }
```


##Usage

### Classes and Defined Types
#### Class: `symantec_scsp`
The `symantec_scsp` module takes care the installation of Symantec SCSP Agent 

**Parameters within `symantec_scsp`:**
#####`ensure`
Possible options are :
* `present` activtes the install and ensures services are running.
* `absent` will remove the SCSP agent.
* `disable` is used to stop the IDS/IPS Services

#####`installer`
The path to a local copy of the SCSP agent

#####`management_server`
The IP  or FQDN of the management server that will manage the agent.

#####`alt_management_servers`
Alternate management server for failover.

#####`ssl_cert_file`
The path to a local copy of the SSL certificate file.

#####`agent_port`
The Agent Port number that was used during management server installation.

#####`install_log`
Installation log file

#####`ids_policy_group`
The name of an existing detection policy group for this agent to join.

##Reference

###Classes
####Public Classes
* [`symantec_scsp`](#class-symantec_scsp): Install the Symantec SCSP package

####Private Classes
* [`symantec_scsp::install`](#class-install): Ensure that SCSP is installed 
* [`symantec_scsp::service`](#class-service): Ensure that SCSP Service state is maintained 


##Limitations

This module was tested with:

* Symantec CSP version 5.2.9.905
* Windows Server 2012 Standard

It is tested with the OSS version of Puppet only.


