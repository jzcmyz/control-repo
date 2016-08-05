class profile::syslog {

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

  package {'rsyslog':
    ensure => absent,
  }

  class {'syslog_ng':
    manage_package => true,
    modules => ['redis'],
#    before => Yumrepo['czanik-syslog-ng36'],
  }

  syslog_ng::config {'version':
    content => '@version: 3.6',
    order => '02',
  }
  syslog_ng::config {'scl':
    content => '@include "scl.conf"',
    order => '03',
  }
  syslog_ng::config {'conf.d':
    content => '@include "/etc/syslog-ng/conf.d/*.conf"',
    order => '04',
  }
  syslog_ng::options {'global_options':
    options => {
      'chain_hostnames' => 'off',
      'create_dirs' => 'yes',
      'flush_lines' => 0,
      'keep_hostname' => 'yes',
      'log_fifo_size' => 1000,
      'stats_freq' => 86400,
      'time_reopen'  => 10,
      'ts-format' => 'iso',
      'use_dns' => 'no',
      'use_fqdn' => 'no',
    }
  }


#
# Source definitions
#
  syslog_ng::source {'s_sys':
    params => [
      { 'type' => 'system',
        'options' => '',
      },
      { 'type' => 'internal',
        'options' => '',
      },
    ]
  }

#
# Destination definitions
#
  syslog_ng::destination {'d_auth':
    params => {
      'type' => 'file',
      'options' => '"/var/log/secure"',
    }
  }
  syslog_ng::destination {'d_boot':
    params => {
      'type' => 'file',
      'options' => '"/var/log/boot.log"',
    }
  }
  syslog_ng::destination {'d_cons':
    params => {
      'type' => 'file',
      'options' => '"/dev/console"',
    }
  }
  syslog_ng::destination {'d_cron':
    params => {
      'type' => 'file',
      'options' => '"/var/log/cron"',
    }
  }
  syslog_ng::destination {'d_kern':
    params => {
      'type' => 'file',
      'options' => '"/var/log/kern"',
    }
  }
  syslog_ng::destination {'d_mail':
    params => {
      'type' => 'file',
      'options' => [
        '"/var/log/maillog"',
        {'flush_lines' => 10},
      ]
    }
  }
  syslog_ng::destination {'d_mesg':
    params => {
      'type' => 'file',
      'options' => '"/var/log/messages"',
    }
  }
  syslog_ng::destination {'d_mlal':
    params => {
      'type' => 'usertty',
      'options' => '"*"',
    }
  }
  syslog_ng::destination {'d_redis':
    params => {
      'type' => 'redis',
      'options' => [
        {'host' => 'redis-1.ring.net'},
        {'port' => 6379},
        {'command' => '"LPUSH", "syslog", "${ISODATE} ${HOST} ${MSGHDR}${MSG}"'},
      ]
    }
  }


#destination d_redis {
#  redis(
#    host("redis-1.ring.net")
#    port(6379)
#    command("LPUSH", "syslog", "${ISODATE} ${HOST} ${MSGHDR}${MSG}")
#  );
#};


  syslog_ng::destination {'d_spol':
    params => {
      'type' => 'file',
      'options' => '"/var/log/spooler"',
    }
  }

#
# Filter definitions
#
  syslog_ng::filter {'f_auth':
    params => {
      'type' => 'facility',
      'options' => ['authpriv']
    }
  }
  syslog_ng::filter {'f_boot':
    params => {
      'type' => 'facility',
      'options' => ['local7']
    }
  }
  syslog_ng::filter {'f_cron':
    params => {
      'type' => 'facility',
      'options' => ['cron']
    }
  }
  syslog_ng::filter {'f_emergency':
    params => {
      'type' => 'level',
      'options' => ['emerg']
    }
  }
  syslog_ng::filter {'f_kernel':
    params => {
      'type' => 'facility',
      'options' => ['kern']
    }
  }
  syslog_ng::filter {'f_mail':
    params => {
      'type' => 'facility',
      'options' => ['mail']
    }
  }
  $f_default='filter f_default {level(info..emerg) and
        not (facility(mail)
        or facility(authpriv)
        or facility(cron)); };'
  syslog_ng::config {'f_default':
    content => $f_default,
    order => '50',
  }
  $f_news='filter f_news {facility(uucp) or
        (facility(news)
        and level(crit..emerg)); };'
  syslog_ng::config {'f_news':
    content => $f_news,
    order => '50',
  }


#
# Log definitions
#
  syslog_ng::log {'auth':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_auth'},
      {'destination' => 'd_auth'},
    ]
  }
  syslog_ng::log {'boot':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_boot'},
      {'destination' => 'd_boot'},
    ]
  }
  syslog_ng::log {'cron':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_cron'},
      {'destination' => 'd_cron'},
    ]
  }
  syslog_ng::log {'default':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_default'},
      {'destination' => 'd_mesg'},
    ]
  }
  syslog_ng::log {'emergency':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_emergency'},
      {'destination' => 'd_mlal'},
    ]
  }
  syslog_ng::log {'kernel':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_kernel'},
      {'destination' => 'd_kern'},
    ]
  }
#  syslog_ng::log {'l_logserver':
#    params => [
#      {'source' => 's_sys'},
#      {'destination' => 'd_logserver'},
#    ]
#  }
  syslog_ng::log {'mail':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_mail'},
      {'destination' => 'd_mail'},
    ]
  }
  syslog_ng::log {'news':
    params => [
      {'source' => 's_sys'},
      {'filter' => 'f_news'},
      {'destination' => 'd_spol'},
    ]
  }

#
# Definitions for the Syslog server
#

  if $role == "server" {
    syslog_ng::source {'s_net':
      params => {
        'type' => 'udp',
        'options' => [
           {'ip' => "'0.0.0.0'"},
           {'port' => 514},
        ]
      }
    }
    syslog_ng::destination {'d_logserver_server':
      params => {
          'type' => 'file',
          'options' => '"/var/log/syslog-ng/${YEAR}/${YEAR}${MONTH}${DAY}/${HOST}.log"',
      }
    }
    syslog_ng::log {'l_logserver_server':
      params => [
        {'source' => 's_net'},
        {'source' => 's_sys'},
        {'destination' => 'd_logserver_server'},
      ]
    }
    cron { compress:
     # command => "find /var/log/syslog-ng/ -type f -mtime +7 -exec gzip {} \;",
      command => 'find /var/log/syslog-ng/ -type f -mtime +7 -exec gzip {} \;',
      user => root,
      hour => 1,
      minute => 0,
      weekday => 0,
    }
  }

#
# Definitions for the Syslog client
#

  if $role == "client" {
    syslog_ng::destination {'d_logserver':
      params => {
        'type' => 'udp',
        'options' => [
          "'logvault-1.ring.net'",
           {'port' => 514},
        #   {'transport' => 'udp'},
        ]
      }
    }
    syslog_ng::log {'l_logserver':
      params => [
        {'source' => 's_sys'},
        {'destination' => 'd_logserver'},
      ]
    }
  }

}



