#!/bin/bash

cd /opt && wget https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip
unzip terraform_0.12.6_linux_amd64.zip
chmod +x terraform
sudo mv terraform /usr/sbin/
