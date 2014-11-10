# Author::    Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright:: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License::   Apache 2.0
#
# === Class: symantec_scsp::install
# 
# This private class is meant to be called from `symantec:scsp`.
# It installs the SCSP Agent
#


class symantec_scsp::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::osfamily {
    'windows': {
      # Note: (Alok) add method to download from remote
      # currently it expects the installer to be present locally
      notify { 'Symantec_SCSP_GetInstaller': name => 'Pulling installer from remote.' }

      $management_server      = $symantec_scsp::management_server
      $ssl_cert_file          = $symantec_scsp::ssl_cert_file
      $agent_port             = $symantec_scsp::agent_port
      $alt_management_servers = $symantec_scsp::alt_management_servers
      $ids_policy_group       = $symantec_scsp::ids_policy_group
      $install_log            = $symantec_scsp::install_log
      $installer              = $symantec_scsp::installer

      $arg_silent = '/s'
      $arg_params = "/v MANAGEMENT_SERVER=${management_server} SSL_CERT_FILE=${ssl_cert_file} AGENT_PORT=${agent_port} ALT_MANAGEMENT_SERVERS=${alt_management_servers} IDS_POLICY_GROUP=${ids_policy_group} -l*v! ${install_log} /qn"

      notify { 'Symantec_SCSP_Install' :
        name => "HIPS with mgmtsrv=${management_server} sslcert=${ssl_cert_file} installlog=${install_log}."
      }

      notify { 'Symantec_SCSP_StartInstall' : name => 'SCSP missing ..installing now.' }
      ->
      package { 'Symantec Critical System Protection Agent':
        ensure          => installed,
        source          => $installer,
        install_options => [ $arg_silent, $arg_params ],
        require         =>  Exec['check_installer_presense']
      }

      $psh_cmd  = 'powershell -executionpolicy remotesigned'
      exec { 'check_installer_presense':
        path      => 'C:/Windows/System32/WindowsPowerShell/v1.0',
        command   => "${psh_cmd} 'return \$true'",
        onlyif    => "${psh_cmd} 'Test-Path ${installer}'"
      }
    }
    default : {
      fail ('This module was built for Windows only.')
    }
  }
}

