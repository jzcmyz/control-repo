class profile::curator_gr {

#
# Logstash requires Java....
# Elasticsearch also requires Java
# Java is installed in the Elasticsearch Module
#

#
# Get stuff out of hiera
#
  ## Hiera lookups
  $curator_server = hiera('curator::server')

  notify{"curator_server = $curator_server":}

  yumrepo {'curator-4':
    name     => 'curator-4',
    descr    => 'CentOS/RHEL 7 repository for Elasticsearch Curator 4.x packages',
    baseurl  => 'http://packages.elastic.co/curator/4/centos/7',
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled  => true,
    gpgcheck => true,
  }
    if $curator_server == true {

    class {'curator':
      manage_repo => false,
      package_name     => 'elasticsearch-curator',
      package_provider => 'yum',
    }

    curator::action { 'delete_indices':
      action                => 'delete_indices',
      continue_if_exception => 'True',
      filters               => [
        {
        'filtertype' => 'pattern',
        'value'      => 'logstash-',
        'kind'       => 'prefix',
      },
      {
        'filtertype' => 'age',
        'direction'  => 'older',
        'timestring' => '"%Y.%m.%d"',
        'unit'       => 'days',
        'unit_count' => '21',
        'source'     => 'name',
        }
      ]
    }

    cron { 'curator_run':
      ensure  => 'present',
      command => '/opt/elasticsearch-curator/curator /root/.curator/actions.yml >/dev/null',
      hour    => 1,
      minute  => 10,
      weekday => '*',
    }
  }

}


