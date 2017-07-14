class profile::linux::gitlab_gr {

  firewall { '080 open Gitlab web port 80':
    proto => tcp,
    action => accept,
    dport => 80,
  }

}

