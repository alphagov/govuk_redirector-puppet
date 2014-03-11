# == Class: redirector::nginx
#
# This class sets up the certs and vhosts for nginx
#
# === Parameters
#
# [*origdom*]
#   This parameter defines what domain to redirect from.
#   The rewrite simply adds www. to the domain specified here.
#
#
# [*ssl_cert*]
#   This is the hiera value with the cert content
#
# [*ssl_key*]
#   This is the hiera value with the key content
#
# === Variables
#
# === Examples
#
#  class { 'redirect::nginx':
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
class redirector::nginx (
  $origdom,
  $cert,
  $key,
  $ssl_cert_file,
  $ssl_key_file,
){

  File {
    owner         => root,
    group         => root,
  }

  file {$ssl_cert_file:
    ensure         => file,
    mode           => '0644',
    content        => $cert,
    notify         => Class['nginx::service'],
  }

  file {$ssl_key_file:
    ensure         => file,
    mode           => '0400',
    content        => $key,
    notify         => Class['nginx::service'],
  }

}
