class profile::syslog_gr {

#
#  get stuff out of hiera
#
  ## Hiera lookups
  $role = hiera('syslog-ng::role')

# For debugging
# notify{"syslog-ng role = $role":}
#
  package { 'syslog-ng' :
    ensure => installed,
  }

  package {'rsyslog':
    ensure => absent,
  }
 
  if $role == 'server' {
    package { 'syslog-ng-redis' :
      ensure => installed,
    }
    file { '/etc/syslog-ng/conf.d/gr_syslog_server.conf':
      ensure => file,
      source => 'puppet:///modules/my_site/gr_syslog_server.conf',
      require => Package['syslog-ng'],
      notify  => Service['syslog-ng'],  # this sets up the relationship
    }
    cron { compress:
      command => 'find /var/log/syslog-ng/ -name "*.log" -type f -mtime +7 -exec gzip {} \;',
      user => root,
      hour => 1,
      minute => 0,
      weekday => 0,
    } 
  }

  service { 'syslog-ng':
    ensure => running,
  }

  file { '/etc/syslog-ng/syslog-ng.conf':
    ensure => file,
    source => 'puppet:///modules/my_site/gr_syslog_client.conf',
    require => Package['syslog-ng'], 
    notify  => Service['syslog-ng'],  # Restart this service when this file changes
  } 
}
