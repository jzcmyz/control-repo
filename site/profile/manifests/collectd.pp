class profile::collectd {


  ## Hiera lookups
  $role = hiera('collectd::role')

#
# This block is configured on the Collectd server to recieve Collectd stats sent from Collectd Clients
# The Collectd server listens on this port. Firewall port needs to opened 
#
#  if $role == 'listener' {
#    firewall { '258 open collectd port 25826':
#      proto => udp,
#      action => accept,
#      dport => 25826,
#    }
#    collectd::plugin::network::listener{['influxdb-1.ring.net']:
#      port => 25826,
#    }
#  }

#
# http://www.pkill.info/linux/man/8-collectd_selinux/
# and
# http://collectd.1051573.n5.nabble.com/collectd-collectd-3112-write-graphite-plugin-Connecting-to-localhost-2003-via-tcp-failed-td5707762.html
#

  selboolean {'collectd_tcp_network_connect':
    persistent => true,
    value => on,
  }

  class {'::collectd':
    purge => true,
    recurse => true,
    purge_config => true,
    minimum_version => '5.4',
   # version => 'latest',
  }

  class {'collectd::plugin::cpu':
    reportbystate => true,
    reportbycpu => true,
    valuespercentage => true,
  }

  class { 'collectd::plugin::df':
    mountpoints    => ['/u'],
    fstypes        => ['nfs','tmpfs','autofs','gpfs','proc','devpts','devtmpfs','sysfs','cgroup','securityfs','rpc_pipefs'],
    ignoreselected => true,
  }

  collectd::plugin {'interface': }
  collectd::plugin {'load': }
  collectd::plugin {'memory': }
  collectd::plugin {'syslog': }

  class {'collectd::plugin::swap':
    reportbydevice => false,
    reportbytes => true,
  }

#
# Send collectd stats to this server
#
  collectd::plugin::network::server{['influxdb-1.ring.net']:
    port => 25826,
  }

  # reminder hiera_hash merges across the heirarchy.
  $c_plugins = hiera_hash('collectd::plugins', {})
  create_resources('collectd::plugin', $c_plugins)

}

