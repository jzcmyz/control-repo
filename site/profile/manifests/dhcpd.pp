class profile::dhcpd {

  # Open DHCP firewall ports
  firewall { '150 open DHCP ports 67 and 68':
    proto => 'udp',
    action => 'accept',
    dport => [ 67, 68 ],
  }

  class {'dhcp':
    dnsdomain    => [
      'ring.net',
      '1.168.192.in-addr.arpa',
      ],
    nameservers  => ['192.168.1.8'],
 #   interfaces   => ['eth0'],
 #   dnsupdatekey => "/etc/bind/keys.d/$ddnskeyname",
 #   require      => Bind::Key[ $ddnskeyname ],
    pxeserver    => '192.168.1.6',
    pxefilename  => 'bootstrap.ipxe',
  }

  dhcp::pool{ 'ring.net':
    network => '192.168.1.0',
    mask    => '255.255.255.0',
    range   => '192.168.1.20 192.168.1.99',
    gateway => '192.168.1.254',
  }
}

