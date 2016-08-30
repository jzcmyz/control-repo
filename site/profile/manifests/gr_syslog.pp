class profile::gr_syslog {

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
