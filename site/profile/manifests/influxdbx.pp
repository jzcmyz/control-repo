class profile::influxdbx {

  ## Hiera lookups
  $role = hiera('collectd::role')

# For debugging
# notify{"syslog-ng role = $role":}
#
  if $role == 'listener' {
    firewall { '258 open collectd port 25826':
      proto => tcp,
      action => accept,
      dport => 25826,
    }
  }

  firewall { '808 open influxdb ports 8083 8086':
    proto => tcp,
    action => accept,
    dport => [ 8083, 8086 ],
  }

  class {'influxdb::server':
    http_auth_enabled => true,
    reporting_disabled => true,
    collectd_options => {
      enabled => true,
      bind-address => ':25826',
      database => 'collectd',
      typesdb => '/usr/share/collectd/types.db',
    },
  }

}

