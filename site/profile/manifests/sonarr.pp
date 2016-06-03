class profile::sonarr {

  firewall { '898 open Sonarr port 8989':
    proto => tcp,
    action => accept,
    dport => 8989,
  }

  yumrepo {'tpokorra-mono-opt':
    descr => 'Copr repo for mono-opt owned by tpokorra',
    baseurl => 'https://copr-be.cloud.fedoraproject.org/results/tpokorra/mono-opt/epel-7-$basearch/',
    gpgkey => 'https://copr-be.cloud.fedoraproject.org/results/tpokorra/mono-opt/pubkey.gpg',
    enabled => true,
    gpgcheck => true,
  }

#  $sonarr_packages = [ 'mediainfo', 'libzen', 'libmediainfo', 'curl', 'gettext', 'mono-core', 'mono-devel', 'sqlite.x86_64' ]
  $sonarr_packages = [ 'mediainfo', 'libzen', 'libmediainfo', 'gettext', 'mono-opt', 'sqlite.x86_64' ]

  package { $sonarr_packages: }

  user { 'sonarr':
    name => 'sonarr',
    ensure => present,
    home => '/var/lib/sonarr',
    shell => '/sbin/nologin',
  }

  archive { 'NzbDrone.master':
    ensure => present,
    url => 'http://update.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz',
    target => '/opt/',
    src_target => '/tmp',
    checksum => false,
  }

  systemd::unit_file { 'sonarr.service':
    source => 'puppet:///modules/my_site/sonarr.service',
  }
#
# Add startup script
# Add Sonarr install steps
#

 file { 'mountpoint_media':
    name => '/mnt/media',
    ensure => 'directory',
  }

  mounttab {'/mnt/media':
    require => File['mountpoint_media'],
    ensure => present,
    fstype => 'nfs',
    device => 'freenas.ring.net:/mnt/datastore/media',
    options => 'defaults',
    provider => augeas,
  }

}
