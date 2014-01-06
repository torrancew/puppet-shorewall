# == Class: shorewall::configure
#
# A class for configuring shorewall
#
# === Parameters:
#
# None
#
# === Variables:
#
# [*params*]
#   A hash that will be used to populate shorewall-parameters
#   Keys become variable names set to their corresponding values
#   Set to $shorewall::parameters
#
# [*policy*]
#   The default catch-all policy
#   Set to $shorewall::policy
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
class shorewall::configure {
  $params = $::shorewall::params
  $policy = $::shorewall::policy
  Class['shorewall::install'] -> Class['shorewall::configure']

  # Basic Shorewall Configuration
  file {
    '/etc/default/shorewall':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/shorewall/default.shorewall';

    '/etc/shorewall':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755';

    '/etc/shorewall/params':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => template('shorewall/params.erb');

    '/etc/shorewall/shorewall.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('shorewall/shorewall.conf.erb');
  }

  # Create concat resources for modularized files
  include concat::setup
  concat {
    '/etc/shorewall/hosts':
      owner => 'root',
      group => 'root',
      mode  => '0644';

    '/etc/shorewall/interfaces':
      owner => 'root',
      group => 'root',
      mode  => '0644';

    '/etc/shorewall/masq':
      owner => 'root',
      group => 'root',
      mode  => '0644';

    '/etc/shorewall/policy':
      owner => 'root',
      group => 'root',
      mode  => '0644';

    '/etc/shorewall/rules':
      owner => 'root',
      group => 'root',
      mode  => '0644';

    '/etc/shorewall/zones':
      owner => 'root',
      group => 'root',
      mode  => '0644';
  }

  # Create headers for concat-based files
  concat::fragment {
    'hosts_header':
      order   => '00',
      target  => '/etc/shorewall/hosts',
      content => template('shorewall/header.hosts.erb');

    'interfaces_header':
      order   => '00',
      target  => '/etc/shorewall/interfaces',
      content => template('shorewall/header.interfaces.erb');

    'masq_header':
      order   => '00',
      target  => '/etc/shorewall/masq',
      content => template('shorewall/header.masq.erb');

    'policy_header':
      order   => '00',
      target  => '/etc/shorewall/policy',
      content => template('shorewall/header.policy.erb');

    'rules_header':
      order   => '00',
      target  => '/etc/shorewall/rules',
      content => template('shorewall/header.rules.erb');

    'zones_header':
      order   => '00',
      target  => '/etc/shorewall/zones',
      content => template('shorewall/header.zones.erb');
  }

  # Define the firewall zone
  shorewall::zone {
    'fw':
      order => '01',
      type  => 'firewall'
  }

  # Define a default policy
  shorewall::policy {
    'default':
      order       => '99',
      source      => 'all',
      destination => 'all',
      policy      => $policy;
  }
}

