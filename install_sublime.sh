#!/bin/bash


# update software sources
sudo apt update

# install sublime text gpg software signing key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg

# add sublime text repo to apt sources
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# ensure apt is set up to work with https sources
sudo apt install apt-transport-https -y

# update software sources again now that sublime text repo has been added
sudo apt update

# install sublime text
sudo apt install sublime-text -y
