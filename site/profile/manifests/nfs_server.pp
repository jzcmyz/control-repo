class profile::nfs_server {

#  mounttab {'/home':
#    ensure => present,
#    fstype => 'xfs',
#    device => '/dev/mapper/vg_home-lv_home',
#    options => 'defaults',
#  }

#
# The bind mounts /home on /export/home for nfsv4 and the automounting of home directories
#

  class {'::nfs':
    server_enabled             => true,
    client_enabled             => true,
    nfs_v4                     => true,
    nfs_v4_idmap_domain        => $::domain,
    nfs_v4_export_root         => '/export',
    nfs_v4_export_root_clients =>
      '*(ro,fsid=root,insecure,no_subtree_check,async,root_squash)',
  }
  nfs::server::export{ '/srv/test':
    ensure  => 'mounted',
    bind    => 'rbind',
    clients => '*(rw,insecure,no_subtree_check,async,no_root_squash) localhost(rw)'
  }
#  nfs::server::export{ '/home':
#    ensure  => 'mounted',
#    bind    => 'rbind',
#    clients => '*(rw,sec=sys:krb5:krb5i:krb5p)',
#    require => Mounttab['/home'],
#  }

#  mounttab {'/tmp':
#    ensure   => present,
#    fstype   => 'xfs',
#    options  => ['nodev','noexec','nosuid'],
#    provider => augeas,
#  }

  mounttab { '/var/tmp':
    ensure  => present,
    device  => '/tmp',
    fstype  => 'none',
    options => ['rw','bind','nodev','noexec','nosuid'],
    provider => augeas,
  }

}

