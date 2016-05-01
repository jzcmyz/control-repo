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

# file { 'mountpoint_downloads':
#    name => '/mnt/downloads',
#    ensure => 'directory',
#    owner  => 'gavin',
#    group  => 'gavin',
#    mode   => '0770',
#  }

#  mounttab {'/mnt/downloads':
#    require => File['mountpoint_downloads'],
#    ensure => present,
#    fstype => 'nfs',
#    device => 'freenas.ring.net:/mnt/datastore/esx-transmission',
#    options => 'defaults',
#    provider => augeas,
#  }

  python::pip { 'transmissionrpc' :
    pkgname       => 'transmissionrpc',
    ensure        => 'latest',
  }
  class {'transmission':
    config_path	   => '/var/lib/transmission',
    download_dir   => '/mnt/downloads',
    web_user       => 'admin',
    web_password   => '{b7518c56374798de52c8ef08d9eb1024119b7afeszwsK/7n',
    web_port       => 9091,
    web_whitelist  => ['127.0.0.1', '192.168.1.*'],
    blocklist_url  => 'http://list.iblocklist.com/?list=bt_templist&fileformat=p2p&archiveformat=gz',
  }

}
