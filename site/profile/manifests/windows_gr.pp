#
# This class installs packages appropriate to the OS release
#
class profile::windows_gr {

  ## Hiera lookups
#  notify{"here it is $packages":}
#  notify{"here it is $redhat7packages":}

  package { 'filezilla':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'gimp':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'launchy':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'notepadplusplus':
    ensure   => installed,
    provider => chocolatey,
  }

}

