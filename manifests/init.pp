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
# $radius_servers = [ { rad_server => "172.16.30.4", rad_secret => "azerty", timeout => '3' },
#                    { rad_server => "192.168.1.2", rad_secret => "qwerty", timeout => '2' } ]
#

class pamradius {
$group        = $pamradius::params::group,
$mode         = $pamradius::params::mode,
$radius_file  = $pamradius::params::radius_file,
$pam_priority = $pamradius::params::pam_priority,
) inherits pamradius::params {
  class{ "pamradius::install": } -> class{ "pamradius::setup": } ~>  class{ "pamradius::services": }
}
