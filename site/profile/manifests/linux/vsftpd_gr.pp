class profile::linux::vsftpd_gr {

  firewall { '210 open FTP port 21':
    proto => tcp,
    action => accept,
    dport => 21,
  }

  selboolean {'allow_ftpd_full_access':
    persistent => true,
    value => on,
  }

  class { 'vsftpd':
    anonymous_enable  => 'NO',
    write_enable      => 'YES',
    ftpd_banner       => 'Marmotte FTP Server',
    chroot_local_user => 'YES',
  }

}

