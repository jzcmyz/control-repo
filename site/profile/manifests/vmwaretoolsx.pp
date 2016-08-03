class profile::vmwaretoolsx {

  class { 'vmwaretools':
    version 	=> '10.0.6-3560309',
    archive_url => 'http://apache-1.ring.net',
    archive_md5 => '92672c721883b0d7a34123933ff2884e',
  }

}
