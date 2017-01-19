class pamradius::install {
  package { $pamradius::params::package:
    ensure  => present,
  }
}
