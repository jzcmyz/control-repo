class profile::puppetmaster {

#
# Open ports used by the Puppet console
#
  firewall { '020 open HTTP/HTTPS ports 80/433':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],

}

