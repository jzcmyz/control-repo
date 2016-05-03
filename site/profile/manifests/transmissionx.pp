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

#  python::pip { 'transmissionrpc' :
#    pkgname       => 'transmissionrpc',
#    ensure        => 'latest',
#  }

#  class {'transmission':
#    rpc_authentication_required         => true,
#    rpc_enabled         => true,
#    transd          => '/var/lib/transmission/.config/transmission-daemon',
#    download_dir   => '/mnt/downloads',
#    rpc_username       => 'admin',
#    rpc_password        => '{5ce6275cd5236f5a3928c5305ec7933769727187FrfUkdQQ',
#    rpc_port            => 9091,
#    rpc_whitelist       => "127.0.0.1,192.168.1.*",
#    blocklist_url  => 'http://list.iblocklist.com/?list=bt_templist&fileformat=p2p&archiveformat=gz',
  }

}
