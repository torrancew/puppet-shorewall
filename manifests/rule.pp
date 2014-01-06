# == Define: shorewall::rule
#
# A type for configuring shorewall rules
#
# === Parameters:
#
# [*action*]
#   The action to apply to matched packets
#   Defaults to 'Drop'
#
# [*source*]
#   The source for this rule
#   Defaults to 'all'
#
# [*destination*]
#   The destination for this rule
#   Defaults to $title
#
# [*protocol*]
#   The protocol to apply this rule to
#   Defaults to '-'
#
# [*orig_dest*]
#   The original destination a packet must have to match this rule
#   Defaults to '-'
#
# [*rate_limit*]
#   The rate limit to apply to matched packets
#   Defaults to '-'
#
# [*user*]
#   The user or group a process should run as to match this rule
#   Defaults to '-'
#
# [*mark*]
#   Marks that packets must have to match this rule
#   Defaults to '-'
#
# [*conn_limit*]
#   The connection limit to apply to matched packets
#   Defaults to '-'
#
# [*time*]
#   Time constraints to apply to this rule
#   Defaults to '-'
#
# [*headers*]
#   Not used for IPv4
#   Defaults to '-'
#
# [*switch*]
#   NetFilter switches for this rule
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
define shorewall::rule(
  $action      = 'Drop',
  $source      = 'all',
  $destination = $title,
  $protocol    = '-',
  $dest_port   = '-',
  $source_port = '-',
  $orig_dest   = '-',
  $rate_limit  = '-',
  $user        = '-',
  $mark        = '-',
  $conn_limit  = '-',
  $time        = '-',
  $headers     = '-',
  $switch      = '-',
  $order       = '50',
) {
  include 'shorewall::configure'
  Shorewall::Rule[$title] ~>
    Class['shorewall::service']

  concat::fragment {
    "rule_${title}":
      order   => $order,
      target  => '/etc/shorewall/rules',
      content => "${action}    ${source}    ${destination}    ${protocol}     ${dest_port}    ${source_port}    ${orig_dest}    ${rate_limit}    ${user}    ${mark}    ${conn_limit}    ${time}    ${headers}    ${switch}\n"
  }
}

