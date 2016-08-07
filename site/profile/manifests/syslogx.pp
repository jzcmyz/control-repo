class profile::syslogx {

#
#  get stuff out of hiera
#
  ## Hiera lookups
  $role = hiera('syslog-ng::role')

# For debugging
# notify{"syslog-ng role = $role":}

#
#  disable the rsyslog service
#
#  service {'rsyslog':
#    ensure => stopped,
#    enable => false,
#  }

  class {'syslog_ng':
#    manage_package => true,
#    modules => ['redis'],
  }

#
# Source definitions
#
syslog_ng::source {'s_sys':
  definition => 'system(); internal();',
}

#
# Destination definitions
#
syslog_ng::destination {'d_auth':
  definition => 'file("/var/log/secure");',
}
syslog_ng::destination {'d_boot':
  definition => 'file("/var/log/boot.log");',
}
syslog_ng::destination {'d_cons':
  definition => 'file("/dev/console");',
}
syslog_ng::destination {'d_cron':
  definition => 'file("/var/log/cron");',
}
syslog_ng::destination {'d_kern':
  definition => 'file("/var/log/kern");',
}
syslog_ng::destination {'d_mail':
  definition => 'file("/var/log/maillog, flush_lines(10)");',
}
syslog_ng::destination {'d_mesg':
  definition => 'file("/var/log/messages);',
}
syslog_ng::destination {'d_mlal':
  definition => 'usertty(*);',
}
syslog_ng::destination {'d_redis':
  definition => 'redis(host(redis-1.ring.net),port(6379),command("LPUSH", "syslog", "${ISODATE} ${HOST} ${MSGHDR}${MSG}");',
}
syslog_ng::destination {'d_spol':
  definition => 'file("/var/log/spooler);',
}

#
# Filter definitions
#
syslog_ng::filter {'f_auth':
  definition => 'facility(authpriv);',
}
syslog_ng::filter {'f_boot':
  definition => 'facility(local7);',
}
syslog_ng::filter {'f_cron':
  definition => 'facility(cron);',
}
syslog_ng::filter {'f_emergency':
  definition => 'level(emerg);',
}
syslog_ng::filter {'f_kernel':
  definition => 'facility(kern);',
}
syslog_ng::filter {'f_mail':
  definition => 'facility(mail);',
}
syslog_ng::filter {'f_default':
  definition => 'level(info..emerg) and not (facility(mail) or facility(authpriv) or facility(cron));',
}
syslog_ng::filter {'f_news':
  definition => 'facility(uucp) or (facility(news) and level(crit..emerg));',
}
#
# Log definitions
#
syslog_ng::log {'auth':
  sources      => [ 's_sys' ],
  filters      => [ 'f_auth' ],
  destinations => [ 'd_auth' ],
}
syslog_ng::log {'boot':
  sources      => [ 's_sys' ],
  filters      => [ 'f_boot' ],
  destinations => [ 'd_boot' ],
}
syslog_ng::log {'cron':
  sources      => [ 's_sys' ],
  filters      => [ 'f_cron' ],
  destinations => [ 'd_cron' ],
}
syslog_ng::log {'default':
  sources      => [ 's_sys' ],
  filters      => [ 'f_default' ],
  destinations => [ 'd_mesg' ],
}
syslog_ng::log {'emergency':
  sources      => [ 's_sys' ],
  filters      => [ 'f_emergency' ],
  destinations => [ 'd_mlal' ],
}
syslog_ng::log {'kernel':
  sources      => [ 's_sys' ],
  filters      => [ 'f_kernel' ],
  destinations => [ 'd_kern' ],
}
syslog_ng::log {'mail':
  sources      => [ 's_sys' ],
  filters      => [ 'f_mail' ],
  destinations => [ 'd_mail' ],
}
syslog_ng::log {'news':
  sources      => [ 's_sys' ],
  filters      => [ 'f_news' ],
  destinations => [ 'd_spol' ],
}


#  if $role == "server" {
#    syslog_ng::source {'s_sys':
#      definition => 'type(udp),ip("0.0.0.0"),port(514)',
#    }
#    syslog_ng::destination {'d_logserver_server':
#      definition => 'file("/var/log/syslog-ng/${YEAR}/${YEAR}${MONTH}${DAY}/${HOST}.log");',
#    }
#      syslog_ng::log {'l_logserver_server':
#      sources      => [ 's_net,s_sys' ],
#      destinations => [ 'd_logserver_server' ]',
#    }
#    cron { compress:
#     # command => "find /var/log/syslog-ng/ -type f -mtime +7 -exec gzip {} \;",
#      command => 'find /var/log/syslog-ng/ -type f -mtime +7 -exec gzip {} \;',
#      user => root,
#      hour => 1,
#      minute => 0,
#      weekday => 0,
#    }
#  }

#
# Definitions for the Syslog client
#

syslog_ng::destination {'d_logserver':
  definition => 'type(udp), host(logvault-1.ring.net),port(514);',
}

syslog_ng::log {'l_logserver':
  sources      => [ 's_sys' ],
  destinations => [ 'd_logserver' ],
}

}

