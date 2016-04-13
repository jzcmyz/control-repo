class profile::flexget {

  python::pip { 'flexget' :
    pkgname       => 'flexget',
  }

  cron {'flexget-run':
    command => '/usr/bin/flexget --cron',
    user    => 'gring',
    hour    => 4,
    minute  => 0,
  }

}

