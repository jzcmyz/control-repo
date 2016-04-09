[root@puppet manifests]# more http.pp
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

  selboolean {['httpd_enable_homedirs','ftp_home_dir']:
    persistent => true,
    value => on,
  }

#  apache::vhost { 'apache.ring.net':
#    port => 80,
#    docroot => '/var/www/html',
#  }

  $vhosts = hiera('apache::vhosts')
  create_resources('apache::vhost',$vhosts)

  collectd::plugin { 'apache': } # turn on Apache plugin within collectd

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

