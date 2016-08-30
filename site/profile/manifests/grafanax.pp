class profile::grafanax {

  firewall { '300 open Grafana port 3000':
    proto => tcp,
    action => accept,
    dport => 3000,
  }

  class {'grafana':
#    install_method => 'repo',
#    manage_package_repo => true,
#
#   This does not work... still installs 2.5 or does not upgrade to v3
#
    install_method  => 'package',
    version         => '3.1.1',
    rpm_iteration   => '1470047149',
  }

}

