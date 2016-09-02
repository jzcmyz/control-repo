class profile::gr_logstash {

#
# Logstash requires Java....
# Elasticsearch also requires Java
# Java is installed in the Elasticsearch Module
#

  include profile::gr_java

  yumrepo {'logstash-2.4':
    name => 'logstash-2.4',
    descr => 'Logstash repository for 2.4.x packages',
    baseurl => 'http://packages.elastic.co/logstash/2.4/centos',
    gpgkey => 'http://packages.elastic.co/GPG-KEY-elasticsearch',
    enabled => true,
    gpgcheck => true,
  }

  class { 'logstash':
    init_defaults => {
      'LS_USER' => 'root',
      'LS_GROUP' => 'root',
    }
  }

#  logstash::configfile { 'inputs.conf':
#    source => "puppet:///modules/logstash/inputs.conf",
#    order => 1,
#  }

##  logstash::configfile { 'filter.conf':
##    source => "puppet:///modules/logstash/filter.conf",
##    order => 10,
##  }

#  logstash::configfile { '001-filter-syslog.conf':
#    source => "puppet:///modules/logstash/001-filter-syslog.conf",
#    order => 10,
#  }

#  logstash::configfile { '002-filter-pfsense.conf':
#    source => "puppet:///modules/logstash/002-filter-pfsense.conf",
#    order => 11,
#  }

#  logstash::configfile { 'outputs.conf':
#    source => "puppet:///modules/logstash/outputs.conf",
#    order => 30,
#  }

}

