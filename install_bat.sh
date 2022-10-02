#!/bin/bash


# update software sources
sudo apt update

# install bat
sudo apt install bat -y

# configure alias to run with bat instead of batcat (for zsh)
echo "" >> ~/.zshrc
echo "alias bat='batcat'" >> ~/.zshrc

# provide feedback
printf '\n[+] Please close your terminal window and reopen it to update changes!'
