# == Class: shorewall
#
# The shorewall module
#
# === Parameters:
#
# [*params*]
#   A hash that will be used to populate shorewall-parameters
#   Keys become variable names set to their corresponding values
#   Defaults to {}
#
# [*policy*]
#   The default catch-all policy
#   Defaults to 'DROP'
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
class shorewall($params = {}, $policy = 'DROP') {
  include shorewall::install
  include shorewall::configure
  include shorewall::service

  anchor { 'shorewall::begin': } -> Class['shorewall::install']
  Class['shorewall::service']    -> anchor { 'shorewall::end': }
}

