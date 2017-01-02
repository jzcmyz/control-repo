class profile::harden_gr {

#
# Rework this to remount the FS if the options are changed.
#
  mounttab {'/tmp':
    ensure => present,
    fstype => 'xfs',
    options => ['nodev','noexec','nosuid'],
    provider => augeas,
  }

  mounttab {'/home':
    ensure => present,
    fstype => 'xfs',
    options => ['nodev'],
    provider => augeas,
  }

  mounttab {'/dev/shm':
    ensure => present,
    fstype => 'tmpfs',
    options => ['nodev'],
    provider => augeas,
  }

  mount { '/tmp': 
    ensure  => mounted, 
    device  => '/var/tmp', 
    fstype  => 'none', 
    options => 'rw,bind', 
  } 

  sysctl { 'net.ipv4.ip_forward':
    ensure => present,
    value  => '0',
  }

  sysctl { 'net.ipv4.conf.all.send_redirects':
    ensure => present,
    value  => '0',
  }

  sysctl { 'net.ipv4.conf.default.send_redirects':
    ensure => present,
    value  => '0',
  }

}

