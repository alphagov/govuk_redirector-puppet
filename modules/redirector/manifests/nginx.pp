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
  $origdom  = '',
  $ssl_cert = '',
  $ssl_key  = '',
){

  File {
    owner         => root,
    group         => root,
  }

  #nginx vhost and ssl bits
  nginx::vhost::redirect {$origdom:
    ssl            => true,
    isdefaultvhost => true,
    dest           => "https://www.${origdom}",
    notify         => Service['nginx'],
  }

  file {"${ssl::params::ssl_path}/${ssl::params::ssl_cert_file}":
    ensure         => file,
    mode           => '0644',
    content        => $ssl_cert,
    notify         => Service['nginx'],
  }

  file {"${ssl::params::ssl_path}/${ssl::params::ssl_key_file}":
    ensure         => file,
    mode           => '0400',
    content        => $ssl_key,
    notify         => Service['nginx'],
  }
}
