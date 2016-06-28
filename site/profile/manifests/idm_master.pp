class profile::idm_master {

  firewall { '053 open BIND/DNS port 53':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => 53,
  }
  firewall { '020 open HTTP/HTTPS ports 80/433':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],
  }
  firewall { '021 open LDAP/LDAPS ports 389/636':
    proto => tcp,
    action => accept,
    dport => [ 389, 636 ],
  }
  firewall { '022 open Kerberos ports 88/464':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => [ 88, 464 ],
  }
  firewall { '023 open Dogtag Certificate System port 7389':
    proto => tcp,
    action => accept,
    dport => 7389,
  }

}
