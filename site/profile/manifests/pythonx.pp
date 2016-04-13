class profile::pythonx {

  class {'python' :
    version    => 'system',
    pip        => 'present',
    dev        => 'absent',
    virtualenv => 'absent',
    gunicorn   => 'absent',
    use_epel   => false,
  }

  python::pip { 'pip' :
    pkgname       => 'pip',
    ensure        => 'latest',
  }

}

