class profile::harden_gr {

  mounttab {'/tmp':
    ensure => present,
    fstype => 'xfs',
    options => ['nodev','nosuid'],
    provider => augeas,
  }

}

