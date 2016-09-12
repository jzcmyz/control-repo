class profile::curator_gr {

#
# Logstash requires Java....
# Elasticsearch also requires Java
# Java is installed in the Elasticsearch Module
#

 yumrepo {'curator-4':
    name => 'curator-4',
    descr => 'CentOS/RHEL 7 repository for Elasticsearch Curator 4.x packages',
    baseurl => 'http://packages.elastic.co/curator/4/centos/7',
    gpgkey => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled => true,
    gpgcheck => true,
  }

  class {'curator':
    package_name => 'python-elasticsearch-curator',
    provider     => 'yum',
  }

  curator::job { 'marvel_delete':
    command      => 'delete',
    prefix       => '.marvel-',
    older_than   => 30,
    cron_hour    => 7,
    cron_minute  => 02
  }
}


