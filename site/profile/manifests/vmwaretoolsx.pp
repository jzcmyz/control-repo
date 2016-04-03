class profile::vmwaretoolsx {

  ## Hiera lookups
#  $country = hiera('ntp::country')

  include vmwaretools
#  class { 'vmwaretools':
#    archive_url => 'http://apache.ring.net',
#    archive_md5 => '9df56c317ecf466f954d91f6c5ce8a6f',
#  }

}
