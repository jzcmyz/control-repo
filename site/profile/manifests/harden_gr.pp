class profile::harden_gr {

# Add security options tothe /tmp file system
  mounttab {'/tmp':
    ensure => present,
    fstype => 'xfs',
    options => ['nodev','noexec','nosuid'],
    provider => augeas,
  }

# Bind Mount /var/tmp To /tmp
  mounttab { '/var/tmp':
    ensure  => present,
    device  => '/tmp',
    fstype  => 'none',
    options => ['rw','bind','nodev','noexec','nosuid'],
    provider => augeas,
  }

  mounttab {'/home':
    ensure => present,
    fstype => 'xfs',
    options => ['nodev'],
    provider => augeas,
  }

#  mounttab {'/dev/shm':
#    ensure => present,
#    device   => "shmfs",
#    fstype => 'tmpfs',
#    options => ['nodev'],
#    provider => augeas,
#  }

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

