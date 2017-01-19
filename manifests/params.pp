class pamradius::params {
  $servers      = 'myserver'
  $secret       = 'mysecret'
  $timeout      = '3'
  $group        = 'root'
  $mode         = '0600'
  # technically openfire runs on windows and mac too, but for the
  # moment only linux support is implemented in this module
  if $::kernel != 'Linux' {
    fail("${module_name} is only supported on Linux")
  }
  case $::operatingsystem {
    Fedora,CentOS,RedHat: {
      $conf_file    = "/etc/pam_radius.conf"
      $package      = ['pam_radius','epel-release']
      $radius_file  = 'puppet:///modules/pamradius/radius'
    }
    Debian,Ubuntu: {
      $conf_file    = "/etc/pamradius.conf"
      $package      = 'libpam-radius-auth'
      $radius_file  = 'puppet:///modules/pamradius/radius'
      $pam_priority = '260'
    }
    default: { fail("${module_name} is not supported on ${::operatingsystem}") }
  }
}
