puppet-pamradius
================

A Puppet module for PAM Radius authentication.


Usage:
------

1. Set globally or locally:
	
		$radius_servers = [ { rad_server => "172.16.30.4", rad_secret => "azerty" },
                    		{ rad_server => "192.168.1.2", rad_secret => "qwerty" } ]
                    		
	This can list just one, or more radius servers with their secrets to auth agaist.
	
2. Just reference the module:

		include pamradius
		

Compatability:
--------------

So far only tested on CentOS 6.x

Any other testing is most welcome.

