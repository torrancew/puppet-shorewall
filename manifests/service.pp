# == Class: shorewall::service
#
# A class to manage the shorewall service
#
# === Parameters:
#
# None
#
# === Variables:
#
# None
#
# === Examples:
#
# None
#
# === Authors:
#
# * Tray Torrance
#
# === Copyright:
#
# Copyright 2013, Tray Torrance
# unless otherwise noted.
#
class shorewall::service {
  Class['shorewall::configure'] ~> Class['shorewall::service']

  exec {
    'shorewall config check':
      command     => '/sbin/shorewall check',
      refreshonly => true;
  }

  service {
    'shorewall':
      ensure  => running,
      enable  => true,
      require => Exec['shorewall config check'];
  }
}

