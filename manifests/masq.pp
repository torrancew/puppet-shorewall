# == Define: shorewall::masq
#
# A type for configuring shorewall policies
#
# === Parameters:
#
# [*interface*]
#   The interface to apply this masq to
#   Required
#
# [*source*]
#   The source address to apply this masq to
#   Defaults to '-'
#
# [*address*]
#   The address to masq as
#   Defaults to $title
#
# [*protocol*]
#   The protocol to apply this masq to
#   Defaults to '-'
#
# [*ipsec*]
#   IPSec policies to match for this masq
#   Defaults to '-'
#
# [*mark*]
#   Marks that packets must have to match this masq
#   Defaults to '-'
#
# [*user*]
#   The user or group a process should run as to match this masq
#   Defaults to '-'
#
# [*switch*]
#   NetFilter switches for this masq
#   Defaults to '-'
#
# [*orig_dest*]
#   The original destination a packet must have to match this masq
#   Defaults to '-'
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
define shorewall::masq(
  $interface,
  $source    = '-',
  $address   = $title,
  $protocol  = '-',
  $ports     = '-',
  $ipsec     = '-',
  $mark      = '-',
  $user      = '-',
  $switch    = '-',
  $orig_dest = '-',
  $order     = '50',
) {
  Shorewall::Masq[$title] ~> Class['shorewall::service']

  concat::fragment {
    "masq_${title}":
      order   => $order,
      target  => '/etc/shorewall/masq',
      content => "${interface}    ${source}    ${address}    ${protocol}    ${ports}    ${ipsec}    ${mark}    ${user}    ${switch}    ${orig_dest}\n"
  }
}

