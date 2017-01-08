class profile::transmission_gr {

  firewall { '100 open Transmission TCP ports 50341':
    proto  => tcp,
    action => accept,
    dport  => 50341,
  }
  firewall { '100 open Transmission UDP ports 50341':
    proto  => udp,
    action => accept,
    dport  => 50341,
  }
  firewall { '102 open Transmission GUI port 9091':
    proto  => tcp,
    action => accept,
    dport  => 9091,
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

#  file { 'mountpoint_downloads':
#    ensure => 'directory',
#    name   => '/mnt/downloads',
#    owner  => 'gavin',
#    group  => 'gavin',
#    mode   => '0770',
#  }

  mounttab {'/mnt/downloads':
    ensure   => present,
#    require  => File['mountpoint_downloads'],
    fstype   => 'nfs',
    device   => 'freenas.ring.net:/mnt/datastore/esx-transmission',
    options  => 'defaults',
    provider => augeas,
  }

  class {'transmission':
    blocklist_enabled           => true,
    blocklist_url               => 'http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz',
    rpc_authentication_required => true,
    rpc_enabled                 => true,
#    download_dir                => '/mnt/downloads',    #download to local directory... not NFS directory
    rpc_username                => 'admin',
    rpc_password                => '{5818041ff6f243971809f55e816a420b9beb6579cvOz.loY',
    rpc_port                    => 9091,
    rpc_whitelist_enabled	=> true,
    rpc_whitelist               => '127.0.0.1,192.168.1.*',
  }

  logrotate::rule { 'transmission':
    path         => '/var/log/transmission/transmission.log',
    rotate       => 4,
    rotate_every => 'week',
    postrotate   => '/bin/systemctl reload transmission-daemon.service > /dev/null 2>/dev/null || true',
  }

}
