#!/bin/bash
set -e -x

# Make sure script is run as root
if [[ "$EUID" -ne 0 ]]; then
    echo "ERROR: This script must be run as root"
    exit 1
fi

# Make sure a hostname is passed
if [[ "$#" -ne 1 ]]; then
    echo "Usage: ./bootstrap.sh hostname"
    exit 1
fi

# Set the hostname
hostnamectl set-hostname "$1"

# Make sure installation is up to date
apt-get -y update
apt-get -y upgrade

# Install packages necessary for bootstrapping
apt-get -y install \
    git \
    openssh-server \
    software-properties-common \
    vim

# Install Ansible
add-apt-repository --yes --update ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible

# Pull down dot_files repo
mkdir -p /home/$(logname)/workspace
git clone https://github.com/nchowning/dot_files.git /home/$(logname)/workspace/dot_files

# Fix the dot_files git repo URL so that I can actually commit/push
sed -i 's/https:\/\/github\.com\/nchowning\/dot_files\.git/git@github.com:nchowning\/dot_files.git/' /home/$(logname)/workspace/dot_files/.git/config
chown -R $(logname) /home/$(logname)/workspace/dot_files

# Run the base dot_files deploy
sudo -u $(logname) /usr/bin/ansible-playbook -c local -K -i localhost, /home/$(logname)/workspace/dot_files/deploy.yaml
