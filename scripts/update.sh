#!/bin/sh

# Pull latest changes
git pull

# TODO: Check if we could pull, or there were errors, abort
#

# Run Ansible install playbooks
./install.sh

