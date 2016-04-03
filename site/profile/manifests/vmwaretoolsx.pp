class profile::vmwaretoolsx {

  class { 'vmwaretools':
    archive_url => 'http://apache-1.ring.net',
    archive_md5 => '92672c721883b0d7a34123933ff2884e',
  }

}
