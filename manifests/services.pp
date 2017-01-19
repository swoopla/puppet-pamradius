class pamradius::services {
  Exec {
        refreshonly => true
  }
  case $::operatingsystem {
    CentOS,RedHat: {
      exec { 'authconfig_pam_radius-updateall':
        command     => '/usr/sbin/authconfig --updateall',
      }
    }
    Debian,Ubuntu: {
      exec { 'pam-auth-update-force':
        environment => 'DEBIAN_FRONTEND=noninteractive',
        command     => '/usr/sbin/pam-auth-update --force',
      }
    }
  }
}
