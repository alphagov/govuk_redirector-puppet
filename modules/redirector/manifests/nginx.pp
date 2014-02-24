class redirector::nginx (
  $origdom  = '',
  $ssl_cert = '',
  $ssl_key  = '',
){
  
  File {
    owner 	  => root,
    group	  => root,
  }

  #nginx vhost and ssl bits
  nginx::vhost::redirect {$origdom:
    ssl            => true,
    isdefaultvhost => true,
    dest           => "https://www.$origdom",
  }

  file {"$ssl::params::ssl_path/$ssl::params::ssl_cert_file":
    ensure         => file,
    mode           => 0644,
    content        => $ssl_cert,
  }

  file {"$ssl::params::ssl_path/$ssl::params::ssl_key_file":
    ensure         => file,
    mode           => 0400,
    content        => $ssl_key,
  }
}
