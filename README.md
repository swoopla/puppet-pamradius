puppet-pamradius
================

A Puppet module for PAM Radius authentication.


Usage:
------

1. Must be set, globally or locally:
	
		$radius_servers = [ { rad_server => "172.16.30.4", rad_secret => "azerty" },
                    		{ rad_server => "192.168.1.2", rad_secret => "qwerty" } ]
                    		
	This can list just one, or multiple radius servers along with their secrets for PAM to authenticate agaist.
	
	*NOTE: Set this variable in your site.pp or somewhere else such that it's available before the template is parsed.*
	
2. And then just reference the module:

		include pamradius
		

Compatability:
--------------

So far only tested on CentOS 6 (may possibly work elsewhere).

Additional testing is most welcome. If this works for you, please share.
