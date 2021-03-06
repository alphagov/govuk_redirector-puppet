# == Class: redirector::firewall
#
# This class sets up the ufw firewall
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  include redirector::firewall
#
# === Authors
#
# Harry Panayiotou <Harry.Panayiotou@digital.cabinet-office.gov.uk>
#
# === Copyright
#
# Copyright 2014  Crown Copyright
#
class redirector::firewall {
  ufw::allow { 'allow-ssh':
    port => '22',
    ip   => 'any'
  }

  ufw::allow { 'allow-http':
    port => '80',
    ip   => 'any'
  }

  ufw::allow { 'allow-https':
    port => '443',
    ip   => 'any'
  }
}
