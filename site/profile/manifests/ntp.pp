class profile::ntp {

  ## Hiera lookups
  #$country = hiera('ntp::country')

  include ntp

}


