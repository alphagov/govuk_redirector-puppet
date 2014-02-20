# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')

  # Some variables and defaults
  $origdom = hiera(origdom)
  $ppa     = hiera(ppa)

  File {
    owner => root,
    group => root,
  } 
  
  #nginx vhost and ssl bits
  nginx::vhost::redirect {$origdom:
    ssl            => true,
    isdefaultvhost => true,
    dest           => "https://www.$origdom",
  }

  file {"$ssl::params::ssl_path/$ssl::params::ssl_cert_file":
    ensure	   => file,
    mode	   => 0644,
    content 	   => hiera(ssl_cert),
  }

  file {"$ssl::params::ssl_path/$ssl::params::ssl_key_file":
    ensure	   => file,
    mode	   => 0400,
    content	   => hiera(ssl_key),
  }

  # Setup sudoers
  create_resources(sudo::conf,hiera_hash('gds_sudo'))
  
  # Setup PPA
  apt::ppa{"$ppa":}
}
