class profile::kibana4i_gr {

#
#
#

  firewall { '560 open Kibana4 port 5601':
    proto => tcp,
    action => accept,
    dport => 5601,
  }

#  class {'kibana4':
#    package_provider   => 'archive',
#    elasticsearch_url  => "http://loghost.ring.net:9200",
#  }

  class { '::kibana4':
    package_ensure    => '4.3.0-linux-x64',
    package_provider  => 'archive',
    symlink           => true,
#    manage_user       => true,
#    kibana4_user      => kibana4,
#    kibana4_group     => kibana4,
#    kibana4_gid       => 200,
#    kibana4_uid       => 200,
    config            => {
        'server.port'           => 5601,
        'server.host'           => '0.0.0.0',
        'elasticsearch.url'     => 'http://elastic-1.ring.net:9200',
        }
  }

}

