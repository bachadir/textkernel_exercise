#!/bin/bash
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i {{ ssh_key_location }}  $1@$(cat ./gitlab-runner | awk '{print$2}') 'gitlab-runner register --url "http://$(cat ./gitlab-server | awk '{print$2}')/" --registration-token "$2" --description "$HOSTNAME"  --executor "shell" --non-interactive'
