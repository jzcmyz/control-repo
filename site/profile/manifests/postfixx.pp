class profile::postfixx {

#  package {'cyrus-sasl-plain':
#    ensure => installed,
#  }

  class {'postfix':
    root_mail_recipient => 'jzcmyz@gmail.com',
  }

  postfix::config {
    'relayhost':                       value => 'smtp.gmail.com:587';
    'smtp_sasl_auth_enable':           value => 'yes';
    'smtp_sasl_password_maps':           value => 'hash:/etc/postfix/sasl_passwd';
    'smtp_sasl_security_options':           value => 'noanonymous';
    'smtp_tls_security_level':           value => 'secure';
    'smtp_tls_mandatory_protocols':           value => 'TLSv1';
    'smtp_tls_mandatory_ciphers':           value => 'high';
    'smtp_tls_secure_cert_match':           value => 'nexthop';
    'smtp_tls_CAfile':           value => '/etc/pki/tls/certs/ca-bundle.crt';
  }

  postfix::hash {'/etc/postfix/sasl_passwd':
    ensure  => 'present',
    source => 'puppet:///modules/my_site/sasl_passwd',
  }

}


