# Author::    Alok Jani (mailto: Alok.Jani@ril.com)
# Copyright:: Copyright (c) 2014 Reliance Jio Infocomm, Ltd
# License::   Apache 2.0
#
# === Class: symantec_scsp::service
#
# This private class is meant to be called from `symantec_scsp` and is for maintaining service state.
#

class symantec_scsp::service  {
  case $symantec_scsp::ensure  {
    'present': {

        # IPS Agent
        service { 'SISIPSService' :
        ensure  =>  'running',
        enable  =>  true,
        }

        # IDS Agent
        service { 'SISIDSService' :
          ensure  => 'running',
          enable  => true,
        }

        # Utils for inter-agent communication
        service { 'SISIPSUtil' :
          ensure   =>  'running',
          enable   =>  true,
        }
      }

    'disable': {

        # IPS Agent
        service { 'SISIPSService' :
          ensure  =>  'stopped',
          enable  =>  true,
        }
        ->
        # IDS Agent
        service { 'SISIDSService' :
          ensure  => stopped,
          enable  => true,
        }
        ->
        # Utils for inter-agent communication
        service { 'SISIPSUtil' :
          ensure  =>  'stopped',
          enable  =>  true,
        }
    }

    default: { }

  }

}

