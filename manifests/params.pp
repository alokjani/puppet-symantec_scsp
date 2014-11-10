# Author::    Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright:: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License::   Apache 2.0
#
# === Class: symantec_scsp::params
#
# This private class is meant to be called from `symantec:scsp`.
# 
#

class symantec_scsp::params {
  $ensure                 = 'present'
  $installer              = 'C:\installers\HIPS_Windows\agent.exe'
  $management_server      = '1.1.1.1'
  $alt_management_servers = '2.2.2.2'
  $ssl_cert_file          = 'C:\installers\HIPS_Windows\agent-cert.ssl'
  $agent_port             = 443
  $install_log            = 'c:\SCSP_install.log'
  $ids_policy_group       = 'Windows'
}
