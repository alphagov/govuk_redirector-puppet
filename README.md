# Redirector Puppet Config

This repo contains the puppet config for the web redirector for gov.uk

# Pre-requisites

Before running puppet, we need to do a bit of gpg to store the certificates in hiera. The operation is as follows:

* Install the following pre-requisites:
```
apt-get update
apt-get install rubygems
gem install hiera-eyaml hiera-eyaml-gpg
```
* mkdir /etc/puppet /etc/puppet/keys && chown -R puppet:puppet /etc/puppet && chmod 700 /etc/puppet/keys

* Generate/import the puppet private and public keys in to home directory (must have no passphrase):
```
	gpg --homedir /etc/puppet/keys --gen-key
```
* Import the various team members
```
	gpg --homedir /etc/puppet/keys --import <team_member>
```
* Chown the files in /etc/puppet/keys to puppet

* Once all the team members are imported, signed and trusted, create a file with list of those users

* Run the following to generate your encrypted block:
```
	eyaml encrypt -n gpg --gpg-recipients-file <file_user_location> --gpg-gnupghome /etc/puppet/keys -f <cert_file/key_file> -o block
```
* Take the block and paste it into the hiera document into the keys provided. E.G. :
```
	ssl_cert: >
	    ENC[GPG,Y22exl+OvjDe+drmik2XEeD3VQtl1uZJXFFF2NnrMXDWx0csyqLB/2NOWefv
	    NBTZfOlPvMlAesyr4bUY4I5XeVbVk38XKxeriH69EFAD4CahIZlC8lkE/uDh
	    jJGQfh052eonkungHIcuGKY/5sEbbZl/qufjAtp/ufor15VBJtsXt17tXP4y
	    l5ZP119Fwq8xiREGOL0lVvFYJz2hZc1ppPCNG5lwuLnTekXN/OazNYpf4CMd
	    /HjZFXwcXRtTlzewJLc+/gox2IfByQRhsI/AgogRfYQKocZgFb/DOZoXR7wm
	    IZGeunzwhqfmEtGiqpvJJQ5wVRdzJVpTnANBA5qxeA==]
```
# Testing

Given the pre-requisites need to occur before a puppet run can be successful, please start your vagrant instances with the --no-provision flag so that you can provision them afterwards when required after all the above steps have been followed. 
