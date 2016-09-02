class profile::gr_java {

  class { 'java':
    distribution => 'jre',
  }

}
