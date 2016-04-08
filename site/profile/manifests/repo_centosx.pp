class profile::repo_centosx {

  class {'repo_centos':
    enable_mirrorlist => false,
    repourl => 'http://repo.ring.net',
  }

}
