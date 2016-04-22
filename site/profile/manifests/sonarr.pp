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
  $sonarr_packages = [ 'mediainfo', 'libzen', 'libmediainfo', 'curl', 'gettext', 'mono-opt', 'sqlite.x86_64' ]

  package { $sonarr_packages: }

}
