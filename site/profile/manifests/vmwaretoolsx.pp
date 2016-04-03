class profile::vmwaretoolsx {

#
# Installing .. VMwareTools-9.0.0-782409.tar.gz
#
  class { 'vmwaretools':
    archive_url => 'http://apache-1.ring.net',
    archive_md5 => '9df56c317ecf466f954d91f6c5ce8a6f',
  }

}
