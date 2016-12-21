class profile::sudo_gr {

  ## Hiera lookups
  #$country = hiera('ntp::country')

  class { 'sudo': }

#  sudo::conf { 'web':
#    source => 'puppet:///files/etc/sudoers.d/web',
#  }
#  sudo::conf { 'admins':
#    priority => 10,
#    content  => "%admins ALL=(ALL) NOPASSWD: ALL",
#  }
#  sudo::conf { 'joe':
#    priority => 60,
#    source   => 'puppet:///files/etc/sudoers.d/users/joe',
#  }

}


