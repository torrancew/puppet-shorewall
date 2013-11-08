# == Define: shorewall::host
#
# A type for configuring shorewall hosts
#
# === Parameters:
#
# [*zone*]
#   The name of the zone this host entry belongs to
#   Required
#
# [*hosts*]
#   The host reference to associate with this entry
#   Defaults to $title
#
# [*options*]
#   The options for the host
#   Defaults to '-'
#
# [*order*]
#   A 2-digit number indicating the order of the generated fragment
#   Defaults to '50'
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
define shorewall::host(
  $zone,
  $hosts    = $title,
  $options  = '-',
  $order    = '50'
) {
  Class['shorewall::configure'] ->
    Shorewall::Host[$title]     ~>
    Class['shorewall::service']

  concat::fragment {
    "host_${title}":
      order   => $order,
      target  => '/etc/shorewall/hosts',
      content => "${zone}    ${hosts}    ${options}\n";
  }
}

