# Info

## Setup

* Install terraform
* make a secrets.tfvars file
  * variables are in the following format
  * do_token = "your_token"
* cd into directory of service you'd like to launch
* run `terraform init`
  * Start Infrastructure
    * run `terraform apply --var-file=/path/to/secrets.tfvars`
  * Destroy Infrastructure
    * run `terraform destroy --var-file=/path/to/secrets.tfvars`

## Providers

### AWS

* Variables
  * aws_access_key
  * aws_secret_key
  * aws_key_name
  * aws_ssh_identity

### Digital Ocean

* Variables
  * do_token
  * do_ssh_fingerprint
  * do_ssh_identity

## Current Infrastructure

* plane-bypass
  * changes the ssh port from 22 to 3128
* docker-install
  * installs docker-ce
* cobaltstrike-server
  * downloads and updates cobaltstrike
  * puppet is used to install cobaltstrike. You'll need to add your license key to the default.pp file under manifests.