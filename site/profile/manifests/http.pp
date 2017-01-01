class profile::http {

  firewall { '020 open HTTP/HTTPS ports 80/433':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],
  }

  class { 'apache':
#    default_vhost => false,
  }

  class { 'apache::mod::status':
    allow_from => ['192.168.1'],
  }

  class { 'apache::mod::info':
    allow_from => ['192.168.1'],
  }

  class { 'apache::mod::php': }
  class { 'apache::mod::userdir': }

# Use Hiera to include modules that are required on this server
# include apache::mod::fastcgi
# include apache::mod::userdir
# include apache::mod::php
# etc

  $modules = hiera('apache_wrapper::modules', '')
    if ($modules != '') {
      apache::mod { $modules : }
  }

#  selboolean {['httpd_enable_homedirs','ftp_home_dir']:
  selboolean {['httpd_enable_homedirs']:
    persistent => true,
    value => on,
  }

#  $vhosts = hiera('apache::vhosts')
#  create_resources('apache::vhost',$vhosts)

  apache::vhost { 'apache-1.ring.net':
    servername => 'apache-1.ring.net',
    port       => '80',
    docroot    => '/var/www/html',
  }

  apache::vhost { 'repo.ring.net':
    servername => 'repo.ring.net',
    port       => '80',
    docroot    => '/srv/centos',
  }

#  collectd::plugin { 'apache': } # turn on Apache plugin within collectd

  mounttab {'/var/www/html/kickstart':
    ensure => present,
    fstype => 'iso9660',
    device => '/var/www/html/CentOS-7-x86_64-Minimal-1511.iso',
    options => 'loop',
    provider => augeas,
  }
  file {'/var/www/html/ks.cfg':
    ensure => file,
    source => 'puppet:///modules/my_site/ks.cfg',
    mode => '0644',
  }

}

