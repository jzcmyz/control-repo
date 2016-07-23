class profile::collectd {


#
# http://www.pkill.info/linux/man/8-collectd_selinux/
# and
# http://collectd.1051573.n5.nabble.com/collectd-collectd-3112-write-graphite-plugin-Connecting-to-localhost-2003-via-tcp-failed-td5707762.html
#

  selboolean {'collectd_tcp_network_connect':
    persistent => true,
    value => on,
  }

  if $operatingsystem == "CentOS" {
    case $operatingsystemrelease {
        /^7.*/: {
        }
        /^6.*/: {
            class {'repoforge' :
              enabled => ['rpmforge', 'testing'],
            }
        }
    }
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

  collectd::plugin {'interface': }
  collectd::plugin {'load': }
  collectd::plugin {'memory': }
  collectd::plugin {'syslog': }

  class {'collectd::plugin::swap':
    reportbydevice => false,
    reportbytes => true,
  }

#  collectd::plugin::write_graphite::carbon {'my_graphite':
#    graphitehost => 'graphite-1.ring.net',
#  }

#
# The "server" sends collectd stats
#
  collectd::plugin::network::server{['influxdb-1.ring.net']:
    port => 25826,
  }

  # reminder hiera_hash merges across the heirarchy.
  $c_plugins = hiera_hash('collectd::plugins', {})
  create_resources('collectd::plugin', $c_plugins)

}

