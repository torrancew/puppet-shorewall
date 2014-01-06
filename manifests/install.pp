# == Class: shorewall::install
#
# A class for installing shorewall
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
class shorewall::install {
  package { 'ipset':     ensure => installed }
  package { 'shorewall': ensure => installed }
}

