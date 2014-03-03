# == Class: redirector
#
# The redirector class initialises the base requirements for the
# gov.uk redirector. This includes setting up a ppa and and the sudoers file
#
# === Parameters
#
# [*ppa*]
#  This is the ppa string for the public repository you wish to add.
#  This is used to ensure you can install the version of nginx you need.
#
# [$gds_sudo*]
#   This parameter allows you to pash a hash of sudo users to sudo::conf to
#   set up the sudo file.
#
# === Variables
#
# === Examples
#
#  class { 'redirect':
#    ppa      => ppa:example/example",
#    gds_sudo => { admins => { priority => '10',
#                              content => '%sudo ALL=(ALL) NOPASSWD: ALL"}}
#  }
#
# === Authors
#
# Harry Panayiotou <Harry.Panayiotou@digital.cabinet-office.gov.uk>
#
# === Copyright
#
# Copyright 2014 Crown Copyright
#
class redirector (
  $ppa      = '',
  $gds_sudo = {},
  $gpg_file = '',
){

  # Setup sudoers
  create_resources(sudo::conf,$gds_sudo)

  # Setup PPA
  apt::ppa{$ppa:
    before  => Class['nginx::server']
  }

  # Add puppet user to recipients file
  file_line { $gpg_file:
    line    => "puppet@$fqdn",
    path    => $gpg_file,
  }

}
