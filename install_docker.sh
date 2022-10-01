#!/bin/bash


# update software sources
sudo apt update

# remove any old versions of docker
sudo apt remove docker docker-engine docker.io containerd runc

# install dependencies
sudo apt install ca-certificates curl gnupg lsb-release -y

# install docker gpg software signing key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# add docker repo to apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update software sources (since docker repo is now present)
sudo apt update

# install docker, docker-ce, docker-compose
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# add regular user to docker group (so we can run docker without sudo)
sudo usermod -aG docker $USER

# update changes to group memberships (logging out and back in work better for group update)
su - ${USER}

# test docker operability as regular user
docker run hello-world

# helpful information
printf '\n[+] If the docker hello-world container ran correctly above, it is installed properly!\n'
printf '\n[!] Log out and back in again to ensure docker group memberships are fully updated.'