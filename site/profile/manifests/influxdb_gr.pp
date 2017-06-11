class profile::influxdb_gr {

  firewall { '808 open influxdb ports 8083 8086':
    proto  => tcp,
    action => accept,
    dport  => [ 8083, 8086 ],
  }

  $global_config = {
    'reporting-disabled' => true,
  }

  $collectd_config = {
    'default' => {
      'enabled'          => true, # not default
      'bind-address'     => ':25826',
      'database'         => 'collectd',
      'typesdb'          => '/usr/share/collectd/types.db',
    }
  }

  $http_config = {
    'enabled'              => true,
    'auth-enabled'         => true,
  }

  class {'influxdb':
    manage_repos    => true,
    manage_service  => true,
    global_config   => $global_config,
    http_config     => $http_config,
    collectd_config => $collectd_config,
  }

}

