class profile::base {

  #the base profile should include component modules that will be on all nodes
  include profile::collectd
#  include profile::epel
  include my_fw
  include profile::networkx
  include profile::ntp
  include profile::packages
#  include profile::postfixx
#  include profile::repo_centosx
  include profile::sshx
  include profile::syslog_gr
  include profile::vmwaretoolsx
  include profile::sudo_gr

}
