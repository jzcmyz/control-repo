class profile::bginfo_gr {

  file { 'c:\program files\bginfo':
    ensure => directory,
  }

  archive { 'BGInfo.zip':
    ensure        => present,
    extract       => true,
#    extract_path  => '/tmp',
    source => 'puppet:///modules/my_site/BGInfo.zip',
    creates       => 'c:\program files\bginfo',
    cleanup       => true,
  }

}

