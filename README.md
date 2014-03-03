# GOV.UK 301 Redirector Puppet Config

This repo contains the puppet config for the 301 redirector for gov.uk. This redirects every request for gov.uk to www.gov.uk.

# Setting up hiera-eyaml-gpg

If you want to use hiera-eyaml-gpg, please follow the steps below:

1. Run tools/genkey to generate the gpg keys in tools/keys

2. Import the relevant user recipients
  ```
  gpg --homedir /etc/puppet/keys --import <users_key>
  ```

3. Bring up your vagrant hosts or re-provision them to transfer the keys.

4. Add an encrypted block to the common.yaml file using one of these two methods:

  1. ##### Copy and Paste an encrypted block

    1. Run the following to generate your encrypted block, setting the gpg-recipients file to hieradata/hiera-eyaml-gpg.recipients:
      ```
      eyaml encrypt -n gpg --gpg-recipients-file <file_user_location> --gpg-gnupghome /etc/puppet/keys -f <cert_file/key_file> -o block
      ```
    2. Take the block and paste it into the appopriate hiera yaml. The keys are ```redirector::nginx::ssl_cert : >``` and ```redirector::nginx::ssl_key: >```. The encrypted should be encapsulated by ```ENC[GPG,<encryped_text>]```. Paste the block below the key and indented as usual.
    
  2. ##### Copy and paste plaintext into the file

    1. Run the following command to modify the file:
      ```
      eyaml edit -n gpg --gpg-gnupghome /etc/puppet/keys <yaml file>
      ```
    2. Copy and paste the cert and key blocks as plaintext into the relevant locations in the yaml file, save and quit
