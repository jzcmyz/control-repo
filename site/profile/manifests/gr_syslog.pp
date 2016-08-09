class profile::gr_syslog {

#
#  get stuff out of hiera
#
  ## Hiera lookups
  $role = hiera('syslog-ng::role')

# For debugging
# notify{"syslog-ng role = $role":}
#
  package { 'syslog-ng':
    ensure => installed,
  }

# ensure apache2 service is running
  service { 'syslog-ng':
    ensure => running,
  }

  file { '/etc/syslog-ng/syslog-ng.conf':
    ensure => file,
    source => 'puppet:///modules/my_site/gr_syslog-ng.txt',
    require => Package['syslog-ng'], 
  } 
}
