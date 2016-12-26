class profile::vim_gr {

  class { 'vim':
    package_ensure => 'latest',
  }

}

