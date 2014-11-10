# Author    :: Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright :: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License   :: Apache 2.0
#
# === Class: symantec_scsp
#
# This module manages the Symantec Critical System Protection Agent
#
# === Parameters
#
# [*ensure*]
#     `present` activates the install and ensures the IDS/IPS services are running.
#     `absent` will remove the SCSP agent.
#     `disable` is used to stop the IDS/IPS Services.
#     Note: that disabling services only stops connection to the management server.
#
# [*installer*]
#     The path to a local copy of the SCSP agent
#
# [*management_server*]
#     The IP  or FQDN of the management server that will manage the agent.
#
# [*alt_management_servers*]
#     Alternate management server for failover.
#
# [*ssl_cert_file*]
#     The path to a local copy of the SSL certificate file.
#
# [*agent_port*]
#     The Agent Port number that was used during management server installation.
#
# [*install_log*]
#     Installation log file
#
# [*ids_policy_group*]
#     The name of an existing detection policy group for this agent to join.


class symantec_scsp (
  $ensure                   = $symantec_scsp::params::ensure,
  $installer                = $symantec_scsp::params::installer,
  $management_server        = $symantec_scsp::params::management_server,
  $alt_management_servers   = $symantec_scsp::params::alt_management_servers,
  $ssl_cert_file            = $symantec_scsp::params::ssl_cert_file,
  $agent_port               = $symantec_scsp::params::agent_port,
  $install_log              = $symantec_scsp::params::install_log,
  $ids_policy_group         = $symantec_scsp::params::ids_policy_group
) inherits symantec_scsp::params {

  if $::operatingsystem != 'windows'  {
    fail ( 'We have not tested this OS yet!' )
  }


  case $ensure {
    /(present)/: {

      if $::symantec_scsp != 'absent' {
        notify { 'Symantec_SCSP_Installed': name => "SCSP Agent version [${::symantec_scsp}] found."}
        ->
        notify { 'Symantec_SCSP_IsRunning': name => 'Ensuring SCSP is running' }
        ->
        class { 'symantec_scsp::service': }
      }

      else {
        notify { 'Symantec_SCSP_Installing': name => 'Starting install for SCSP Agent.'}
        ->
        class { 'symantec_scsp::install': }
      }
    }

    /(absent)/: {
      notify { 'Symantec_SCSP_UninstallBegin':  name => 'Uninstalling Symantec SCSP Agent.' }
      ->
      package { 'Symantec Critical System Protection Agent' :
        ensure  => absent,
      }
      ->
      notify { 'Symantec_SCSP_UninstallEnd':  name => 'Uninstall Complete' }
    }

    /(disable)/: {
      if $::symantec_scsp != 'absent' {
        notify { 'Symantec_SCSP_Disable' : name => 'Ensuring Symantec SCSP is stopped.' }
        ->
        class { 'symantec_scsp::service' : }
      }
    }

    default : {
      fail ('ensure paramter must be present or absent')
    }
  }

}

