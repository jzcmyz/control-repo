class role::downloader {

  #This role would be made of all the profiles that need to be included to make a webserver work
  #All roles should include the base profile
  include profile::base
  include profile::pythonx
#  include profile::flexget
  include profile::transmission_gr
  include profile::sonarr

}
