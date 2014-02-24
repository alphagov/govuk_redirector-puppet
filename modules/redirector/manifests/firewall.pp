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
