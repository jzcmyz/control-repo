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

  mount { '/tmp': 
    ensure  => mounted, 
    device  => '/var/tmp', 
    fstype  => 'none', 
    options => 'rw,bind', 
  } 

}

