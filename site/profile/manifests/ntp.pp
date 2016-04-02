class profile::ntp {

#
#  get stuff out of hiera
#
  ## Hiera lookups
  $country = hiera('ntp::country')

  include ntp

}


