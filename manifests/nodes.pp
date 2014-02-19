# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')

  nginx::vhost::redirect {'gov.uk':
    ssl            => true,
    isdefaultvhost => true,
    dest           => 'https://www.gov.uk',
  }

  file {$ssl::params::ssl_cert_file:
    ensure	   => file,
    owner	   => root,
    group	   => root,
    mode	   => 0644,
    content 	   => hiera(ssl_cert),
  }

  file {$ssl::params::ssl_key_file:
    ensure	   => file,
    owner	   => root,
    group	   => root,
    mode	   => 0400,
    content	   => hiera(ssl_key),
  }
}
