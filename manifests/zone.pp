# == Define: shorewall::zone
#
# A type for configuring shorewall zones
#
# === Parameters:
#
# [*zone*]
#   The name of the zone
#   Defaults to $title
#
# [*type*]
#   The type of the zone
#   Defaults to 'ip'
#
# [*options*]
#   The options for the zone
#   Defaults to '-'
#
# [*in_opts*]
#   The input options for the zone
#   Defaults to '-'
#
# [*out_opts*]
#   The output options for the zone
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
define shorewall::zone(
  $zone     = $title,
  $type     = '-',
  $options  = '-',
  $in_opts  = '-',
  $out_opts = '-',
  $order    = '50'
) {
  Shorewall::Zone[$title] ~> Class['shorewall::service']

  concat::fragment {
    "zone_${title}":
      order   => $order,
      target  => '/etc/shorewall/zones',
      content => "${zone}    ${type}    ${options}    ${in_opts}    ${out_opts}\n";
  }
}

