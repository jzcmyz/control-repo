class profile::logstash_gr {

#
# Logstash requires Java....
# Elasticsearch also requires Java
# Java is installed in the Elasticsearch Module
#

  include profile::java_gr

  yumrepo {'logstash-2.4':
    name     => 'logstash-2.4',
    descr    => 'Logstash repository for 2.4.x packages',
    baseurl  => 'http://packages.elastic.co/logstash/2.4/centos',
    gpgkey   => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled  => true,
    gpgcheck => true,
  }

  class { 'logstash':
    status => enabled,
    init_defaults => {
      'LS_USER'  => 'root',
      'LS_GROUP' => 'root',
    }
  }

  logstash::configfile { '001-syslog-to-elasticsearch.conf':
    source => 'puppet:///modules/my_site/001-syslog-to-elasticsearch.conf',
    order  => 10,
  }

  logstash::configfile { '002-pfsense-to-elasticsearch.conf':
    source => 'puppet:///modules/my_site/002-pfsense-to-elasticsearch.conf',
    order  => 11,
  }

}

