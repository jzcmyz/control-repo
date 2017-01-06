#
# This class installs packages appropriate to the OS release
#
class profile::windows_gr {

  ## Hiera lookups
#  notify{"here it is $packages":}
#  notify{"here it is $redhat7packages":}

  package { 'notepadplusplus':
    ensure   => installed,
    provider => chocolatey,
  }

}

