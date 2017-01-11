#
# This class installs packages appropriate to the OS release
#
class profile::windows_gr {

  ## Hiera lookups
#  notify{"here it is $packages":}
#  notify{"here it is $redhat7packages":}

  class {'chocolatey':
    use_7zip                        => false,
  }

  package { 'bginfo':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'dotnet3.5':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'filezilla':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'gimp':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'googlechrome':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'googledrive':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'keepass':
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

  package { 'putty':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'superputty':
    ensure   => installed,
    provider => chocolatey,
    require  => Package['dotnet3.5']
  }

  package { 'transgui':
    ensure   => installed,
    provider => chocolatey,
  }

  package { 'vlc':
    ensure   => installed,
    provider => chocolatey,
  }

}

