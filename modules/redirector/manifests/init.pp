class redirector (
  $ppa 	    = '',
  $gds_sudo = {}
){

  # Setup sudoers
  create_resources(sudo::conf,$gds_sudo)

  # Setup PPA
  apt::ppa{"$ppa":}
}
