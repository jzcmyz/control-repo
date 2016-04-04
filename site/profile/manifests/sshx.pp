class profile::sshx {

  sshd_config {'PrintMotd':
    ensure => present,
    value  => 'no',
  }

  sshd_config {'X11Forwarding':
    ensure => present,
    value  => 'yes',
  }

  sshd_config_subsystem {'sftp':
    ensure  => present,
    command => '/usr/libexec/openssh/sftp-server',
  }

}

