class profile::transmissionx {

  firewall { '100 open Transmission ports 50341':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => 50341,
  }

  firewall { '102 open Transmission GUI port 9091':
    proto => tcp,
    action => accept,
    dport => 9091,
  }

  ## Hiera lookups
#  $crontabs = hiera('system::crontabs')

#  include system::crontabs
#  cron {'transmission-blocklist':
#    command => '/usr/bin/transmission-remote -n admin:password --blocklist-update',
#    user    => 'transmission',
#    hour    => 11,
#    minute  => 0,
#  }

  class {'transmission':
    config_path	   => "/var/lib/transmission",
#    download_dir   => "/downloads",
#    incomplete_dir => "/tmp/downloads",
    web_port       => 9091,
    web_whitelist  => ['127.0.0.1', '192.168.1.*'],
#    blocklist_url  => 'http://list.iblocklist.com/?list=bt_level1',
  }

}
