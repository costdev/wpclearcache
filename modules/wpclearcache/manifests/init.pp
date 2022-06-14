# Name:        WP Clear Cache
# Description: Frees reclaimable slab objects (includes dentries and inodes) when WordPress updates a plugin or theme.
# Author:      WordPress Core Contributors
# Author URI:  https://make.wordpress.org/core
# License:     GPLv2 or later
# Version:     1.0.0

class wpclearcache (
	$config
) {
	# Ensure permission is granted for these tasks.
	if ( ! empty( $config[disabled_extensions] ) and 'costdev/chassis-wpclearcache' in $config[disabled_extensions] ) {
		$directory = absent
		$file      = absent
	} else {
		$directory = 'directory'
		$file      = present
	}

	# Ensure that the mu-plugins directory exists.
	file { '/vagrant/content/mu-plugins':
		ensure  => $directory,
		force   => true,
		require => Chassis::Wp[ $config['hosts'][0] ]
	}

	# Ensure that the mu-plugin exists.
	file { '/vagrant/content/mu-plugins/wpclearcache.php':
		content => template('wpclearcache/wpclearcache.php.erb'),
		ensure  => $file,
		require => Chassis::Wp[ $config['hosts'][0] ]
	}

	# Ensure that the watcher script exists.
	file { '/etc/init.d/wpclearcache.sh':
		content => template('wpclearcache/wpclearcache.sh.erb'),
		ensure  => $file,
		mode    => '500',
		require => Chassis::Wp[ $config['hosts'][0] ]
	}

	# Ensure CRLF has not been used for the watcher script.
	exec { 'strip CRLF from watcher':
		command => "/usr/bin/sed -i 's/\r$//' /etc/init.d/wpclearcache.sh",
		user    => 'root',
		require => Chassis::Wp[ $config['hosts'][0] ]
	}

	# Run the watcher script.
	exec { 'run watcher':
		command => '/etc/init.d/wpclearcache.sh &',
		user    => 'root',
		require => Chassis::Wp[ $config['hosts'][0] ]
	}

	# Add the watcher to startup scripts.
	exec { 'add watcher to startup scripts':
		command => '/usr/sbin/update-rc.d wpclearcache.sh defaults',
		user    => 'root',
		require => Chassis::Wp[ $config['hosts'][0] ]
	}
}
