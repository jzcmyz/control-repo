class profile::influxdbx {

  firewall { '808 open influxdb ports 8083 8086':
    proto => 'tcp',
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

