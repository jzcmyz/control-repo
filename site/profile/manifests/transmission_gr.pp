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

  cron {'transmission-blocklist':
    command  => '/usr/bin/transmission-remote -n admin:password --blocklist-update',
    user     => 'transmission',
    monthday => 1,
    hour     => 11,
    minute   => 15,
  }

  class {'transmission':
    blocklist_enabled           => true,
    blocklist_url               => 'http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz',
    peer_port                   => 50341, # This port is open on the pfsense firewall
    ratio_limit_enabled         => true,
    rpc_authentication_required => true,
    rpc_enabled                 => true,
    rpc_username                => 'admin',
    rpc_password                => '{5818041ff6f243971809f55e816a420b9beb6579cvOz.loY',
    rpc_port                    => 9091,
    rpc_whitelist_enabled       => true,
    rpc_whitelist               => '127.0.0.1,192.168.1.*',
    transd                      => '/var/lib/transmission',
  }

  logrotate::rule { 'transmission':
    path         => '/var/log/transmission/transmission.log',
    rotate       => 4,
    rotate_every => 'week',
    postrotate   => '/bin/systemctl reload transmission-daemon.service > /dev/null 2>/dev/null || true',
  }
 
#
# Create the override file for the transmission daemon
#
  file { '/etc/systemd/system/transmission-daemon.service.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/systemd/system/transmission-daemon.service.d/override.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source => 'puppet:///modules/my_site/transmission/override.conf',
    notify  => Service['transmission-daemon'],  # this sets up the relationship
  }

}
