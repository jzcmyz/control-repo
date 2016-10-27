class profile::elasticsearch_gr {

  firewall { '920 open Elasticsearch port 9200':
    proto => tcp,
    action => accept,
    dport => 9200,
  }

  firewall { '930 open Elasticsearch transport module ports 9300-9400':
    proto => tcp,
    action => accept,
    dport => ["9300-9400"],
  }

#
# Elasticsearch is built using Java, and requires at least Java 7 in order to run.
#

  include profile::java_gr

# Mount the volume for /elasticsearch
# This is broken
#  file { 'mountpoint':
#    path => '/elasticsearchx',
#    ensure => 'directory',
#  }

  mounttab {'/elasticsearch':
    ensure      => present,
    fstype      => 'xfs',
    device      => '/dev/mapper/elastic_vg-elastic_lv',
    options     => 'defaults',
    provider    => augeas,
  }

  yumrepo {'elasticsearch-2.x':
    name => 'elasticsearch-2.x',
    descr => 'Elasticsearch repository for 2.x packages',
    baseurl => 'http://packages.elastic.co/elasticsearch/2.x/centos',
    gpgkey => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled => true,
    gpgcheck => true,
  }

  $node_data = true
  $node_master = true
  $elasticsearch_defaults = hiera('elasticsearch::defaults')


#  $node_data = hiera('elasticsearch::config::node.data')
#  $node_master = hiera('elasticsearch::config::node.master')
#  $elasticsearch_defaults = hiera('elasticsearch::defaults')

#  notify{"elasticsearch_defaults = $elasticsearch_defaults":}

  class {'elasticsearch':
    before => Yumrepo['elasticsearch-2.x'],
    java_install => false,
    datadir => '/elasticsearch',
    init_defaults => $elasticsearch_defaults,
    config => {
      'http.cors.enabled' => true,
      'discovery.zen.ping.multicast.enabled' => false,
    }
  }

  elasticsearch::instance {'es-01':
    before => Mounttab['/elasticsearch'],
    config => {
      'cluster.name'            => 'elastic',
      'node.data'               => "$node_data",
      'node.master'             => "$node_master",
      'node.name'               => "${::hostname}",
      'network.host'            => "${::ipaddress}",
 #     'bootstrap.mlockall'     => true, does not work... OS changes need to be made
 #     'discovery.zen.ping.unicast.hosts'       => '["logvault-1.ring.net","elastic-1.ring.net","elastic-2.ring.net","elastic-3.ring.net"]',
      'discovery.zen.ping.unicast.hosts'        => '["elastic-1.ring.net","elastic-2.ring.net","elastic-3.ring.net"]',
      'discovery.zen.minimum_master_nodes'      => 1,
    }
  }

  elasticsearch::plugin{'mobz/elasticsearch-head':
    instances  => 'es-01'
  }
#
#  Marvel needs a license
#
#  elasticsearch::plugin{'license':
#    instances  => 'es-01'
#  }
#
#  elasticsearch::plugin{'marvel-agent':
#    instances  => 'es-01'
#  }

}

