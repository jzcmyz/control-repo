class my_fw::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto => 'icmp',
    action => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto => 'all',
    iniface => 'lo',
    action => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto => 'all',
    state => [ 'RELATED', 'ESTABLISHED' ],
    action => 'accept',
  }->
  firewall { '003 accept SSH':
    proto => tcp,
    action => accept,
    dport => 22,
  }->
  firewall { '010 open DNS port 53':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => 53,
  }->
  firewall { '010 open NTP port 123':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => 123,
  }->
  firewall { '010 open Syslog port 514':
    proto => [ 'tcp', 'udp' ],
    action => accept,
    dport => 514,
  }->
#  firewall { '010 open Puppet port 8140':
#    proto => tcp,
#    action => accept,
#    dport => 8140,
#  }->
#  firewall { '010 open mcollective unencrypted port 61613':
#    proto => tcp,
#    action => accept,
#    dport => 61613,
#  }->
#  firewall { '011 open mcollective SSL port 61614':
#    proto => 'tcp',
#    action => accept,
#    dport => 61614,
#  }->
  firewall { '024 open nfsv4 port 2049':
    proto => tcp,
    action => accept,
    dport => 2049,
  }
#  firewall { '999 Drop everything else':
#    action => drop,
#  }
}

