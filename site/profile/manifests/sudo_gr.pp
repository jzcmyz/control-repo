class profile::sudo_gr {

  ## Hiera lookups
  #$country = hiera('ntp::country')

  class { 'sudo': }

  sudo::conf { 'root':
    priority => 10,
    content  => 'root ALL=(ALL)	ALL',
  }
  sudo::conf { 'avdmade':
    priority => 11,
    content  => 'avdmade ALL=(ALL) ALL',
  }
  sudo::conf { 'vot0':
    priority => 12,
    content  => 'vot0 ALL=(ALL) ALL',
  }
  sudo::conf { 'silvaen':
    priority => 13,
    content  => 'silvaen ALL=(ALL) ALL',
  }
  sudo::conf { 'ringg':
    priority => 14,
    content  => 'ringg ALL=(ALL) ALL',
  }
  sudo::conf { 'kazita':
    priority => 15,
    content  => 'kazita ALL=(ALL) ALL',
  }
  sudo::conf { 'pentest1_admin':
    priority => 16,
    content  => 'pentest1_admin ALL=(ALL) ALL',
  }
  sudo::conf { 'pentest2_admin':
    priority => 17,
    content  => 'pentest2_admin ALL=(ALL) ALL',
  }
  sudo::conf { 'gavin':
    priority => 18,
    content  => 'gavin ALL=(ALL) ALL',
  }


}


