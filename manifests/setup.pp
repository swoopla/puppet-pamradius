class pamradius::setup {
  File {
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    backup => false,
  }
  file {"$pamradius::conf_file":
    content => template("pamradius/pam_radius.conf.erb"),
    group   => $pamradius::group,
    mode    => $pamradius::mode,
  }
  case $::operatingsystem {
    Fedora,CentOS,RedHat: {
      file {
        "/etc/pam.d/system-auth-local": source  => 'puppet:///modules/pamradius/system-auth-local';
        "/etc/pam.d/system-auth":       ensure => link, target => "system-auth-local", seluser => 'unconfined_u', require => File['/etc/pam.d/system-auth-local'];
      }
      file {
        "/etc/pam.d/password-auth-local": source  => 'puppet:///modules/pamradius/password-auth-local';
        "/etc/pam.d/password-auth":       ensure => link, target => "password-auth-local", seluser => 'unconfined_u', require => File['/etc/pam.d/password-auth-local'];
      }
    }
    Debian,Ubuntu: {
      file {'/usr/share/pam-configs/radius':
        content => template("pamradius/radius.erb"),
      }
    }
  }
}
