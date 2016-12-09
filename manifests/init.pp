# Class: pamradius
# ===========================
#
# Parameters
# ----------
#
# * `radius_servers`
# Defines the array of one or more radius 
# servers (IP or hostname) with their associated secrets.
# 
# Author
# -------
#
# Daniel Shaw <daniel@techdad.xyz>
#
# License
# -------
#
# Apache 2.0
#

class pamradius {

# package(s) needed
# dependency repo
package { 'epel-release':
  ensure => 'installed',
}
# the actual package we need
package { 'pam_radius':
  ensure => 'installed',
}

# update the main config
file { '/etc/pam_radius.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0600',
  content => template('pamradius/pam_radius.conf.erb'),
}

# reference the module in local pam configs
file { '/etc/pam.d/password-auth-local':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/pamradius/password-auth-local'
}
file { '/etc/pam.d/system-auth-local':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/pamradius/system-auth-local'
}

# link them into the system if updated
# (this may be CentOS/RHEL specific..)
file { '/etc/pam.d/password-auth':
  ensure => link,
  target => 'password-auth-local'
}
file { '/etc/pam.d/system-auth':
  ensure => link,
  target => 'system-auth-local'
}

# and create some system defaults if the locals are created
# (this may be CentOS/RHEL specific too..)
exec { 'authconfig':
  command     => '/usr/sbin/authconfig --updateall',
  subscribe   => [ File['/etc/pam.d/password-auth-local'],
    File['/etc/pam.d/system-auth-local'],
    File['/etc/pam.d/password-auth'],
    File['/etc/pam.d/system-auth'],
    ],
  refreshonly => true
}

}
