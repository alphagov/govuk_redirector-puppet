# Redirector Puppet Config

This repo contains the puppet config for the web redirector for gov.uk

# Pre-requisites

Before running puppet, we need to do a bit of gpg to store the certificates in hiera. The operation is as follows:

1. Run tools/genkey to generate the gpg keys in /etc/puppet/keys

2. Import the various team members
  ```
  gpg --homedir /etc/puppet/keys --import <team_member>
  ```
3. Chown the files in /etc/puppet/keys to puppet

4. Add the gpg puppet email just created to hieradata/hiera-eyaml-gpg.recipients

5. Add an encrypted block to the common.yaml file using one of these two methods:

  1. ##### Copy and Paste an encrypted block

    1. Run the following to generate your encrypted block, setting the gpg-recipients file to hieradata/hiera-eyaml-gpg.recipients:
      ```
      eyaml encrypt -n gpg --gpg-recipients-file <file_user_location> --gpg-gnupghome /etc/puppet/keys -f <cert_file/key_file> -o block
      ```
    2. Take the block and paste it into the hiera document into the keys provided. Paste the block below the key and indented as usual.
    
  2. ##### Copy and paste plaintext into the file

    1. Run the following command to modify the file:
      ```
      eyaml edit -n gpg --gpg-gnupghome /etc/puppet/keys <yaml file>
      ```
    2. Copy and paste the cert and key blocks as plaintext into the relevant locations in the yaml file, save and quit

# Testing

Given the pre-requisites need to occur before a puppet run can be successful, please start your vagrant instances with the --no-provision flag so that you can provision them afterwards when required after all the above steps have been followed. 
