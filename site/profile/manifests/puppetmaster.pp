class profile::puppetmaster {

#
# Open ports used by the Puppet console
#
  firewall { '020 open HTTP/HTTPS ports 80/433':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],
  }
  firewall { '817 open code manager port 8170':
    proto => tcp,
    action => accept,
    dport => 8170,
  }


}

