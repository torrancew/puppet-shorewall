# == Define: shorewall::interface
#
# A type for configuring shorewall interfaces
#
# === Parameters:
#
# [*zone*]
#   The name of the zone
#   Required
#
# [*interface*]
#   The name of the interface
#   Defaults to $title
#
# [*opts*]
#   The options for the interface
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
define shorewall::interface(
  $zone,
  $interface = $title,
  $opts      = '-',
  $order     = '50'
) {
  Shorewall::Interface[$title] ~> Class['shorewall::service']

  concat::fragment {
    "interface_${title}":
      order   => $order,
      target  => '/etc/shorewall/interfaces',
      content => "${zone}    ${interface}    ${opts}\n";
  }
}

