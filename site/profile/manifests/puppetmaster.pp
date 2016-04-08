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

}
