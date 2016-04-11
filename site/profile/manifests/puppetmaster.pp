class profile::puppetmaster {

#
# Open ports used by Puppet
#
  firewall { '020 open HTTP/HTTPS ports 80/433':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],
  }
  firewall { '817 open Code Manager port 8170':
    proto => tcp,
    action => accept,
    dport => 8170,
  }
  firewall { '010 open Puppet port 8140':
    proto => tcp,
    action => accept,
    dport => 8140,
  }
  firewall { '010 open Mcollective unencrypted port 61613':
    proto => tcp,
    action => accept,
    dport => 61613,
  }
  firewall { '011 open Mcollective SSL port 61614':
    proto => 'tcp',
    action => accept,
    dport => 61614,
  }

}
