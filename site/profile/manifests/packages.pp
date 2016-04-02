class profile::packages {

  ## Hiera lookups
  $redhat6packages = hiera('redhat6::packages')
  $redhat7packages = hiera('redhat7::packages')

#  notify{"here it is $packages":}
#  notify{"here it is $redhat7packages":}

  if $operatingsystemmajrelease == "6" {
    package { $redhat6packages: }
  }

  if $operatingsystemmajrelease == "7" {
    package { $redhat7packages: }
  }

}

