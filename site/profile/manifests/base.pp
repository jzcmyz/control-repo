class profile::base {

  #the base profile should include component modules that will be on all nodes
  include profile::ntp
  include profile::packages
  include profile::vmwaretoolsx

}
