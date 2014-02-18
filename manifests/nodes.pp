# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')

  nginx::vhost::redirect {'gov.uk':
    ssl            => true,
    isdefaultvhost => true,
    dest           => 'https://www.gov.uk',
  }

}
