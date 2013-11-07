# == Define: shorewall::policy
#
# A type for configuring shorewall policies
#
# === Parameters:
#
# [*source*]
#   The source for this policy
#   Defaults to 'all'
#
# [*destination*]
#   The destination for this policy
#   Defaults to $title
#
# [*policy*]
#   The policy to apply to matched packets
#   Defaults to 'Drop'
#
# [*log_level*]
#   The log level to apply to matched packets
#   Defaults to '-'
#
# [*rate_limit*]
#   The rate limit to apply to matched packets
#   Defaults to '-'
#
# [*conn_limit*]
#   The connection limit to apply to matched packets
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
define shorewall::policy(
  $source      = 'all',
  $destination = $title,
  $policy      = 'Drop',
  $log_level   = '-',
  $rate_limit  = '-',
  $conn_limit  = '-',
  $order       = '50',
) {
  Shorewall::Policy[$title] ~> Class['shorewall::service']

  concat::fragment {
    "policy_${title}":
      order   => $order,
      target  => '/etc/shorewall/policy',
      content => "${source}    ${destination}    ${policy}    ${log_level}    ${rate_limit}    ${conn_limit}\n";
  }
}

