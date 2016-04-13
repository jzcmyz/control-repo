class profile::grafanax {

  firewall { '300 open Grafana port 3000':
    proto => 'tcp',
    action => accept,
    dport => 3000,
  }

  class {'grafana':
    install_method => 'repo',
    manage_package_repo => true,
  }

}
