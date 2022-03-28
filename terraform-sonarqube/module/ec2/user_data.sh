#!/bin/bash
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt install ansible -y
sudo apt install docker.io docker-compose -y
sudo systemctl start docker.service
cd ~ && sudo docker-compose up -d 