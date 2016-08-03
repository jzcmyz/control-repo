c
ass profile::vmwaretoolsx {

#
# Installing .. VMwareTools-9.0.0-782409.tar.gz
#
  class { 'vmwaretools':
    version 	=> '10.0.6-3560309',
    archive_url => 'http://apache-1.ring.net',
 #   archive_md5 => '9df56c317ecf466f954d91f6c5ce8a6f',
    archive_md5 => '92672c721883b0d7a34123933ff2884e',
  }

}
