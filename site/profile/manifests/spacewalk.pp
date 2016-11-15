class profile::spacewalk {

  firewall { '808 open spacewalk web interface ports 80 and 443':
    proto => tcp,
    action => accept,
    dport => [ 80, 443 ],
  }
  firewall { '522 open spacewalk ports to allow push actions to clients on 5222':
    proto => tcp,
    action => accept,
    dport => [ 5222 ],
  }
  firewall { '69 open spacewalk ports to allow tftp kickstart on 69':
    proto => tcp,
    action => accept,
    dport => [ 69 ],
  }

}
