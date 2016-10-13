class profile::speedtest {

#
#  get stuff out of hiera
#
  ## Hiera lookups
  $role = hiera('syslog-ng::role')

# For debugging
# notify{"syslog-ng role = $role":}
#

  python::pip { 'speedtest-cli' :
    pkgname => 'speedtest-cli',
  }

#  cron {'flexget-run':
#    command => '/usr/bin/flexget --cron',
#    user    => 'gring',
#    hour    => 4,
#    minute  => 0,
#  }

#  file { '/etc/syslog-ng/syslog-ng.conf':
#    ensure => file,
#    source => 'puppet:///modules/my_site/gr_syslog_client.conf',
#    require => Package['syslog-ng'], 
#    notify  => Service['syslog-ng'],  # Restart this service when this file changes
#  } 

}
