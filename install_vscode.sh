#!/bin/bash


# update software sources
sudo apt update

# download vscode installer
wget https://az764295.vo.msecnd.net/stable/74b1f979648cc44d385a2286793c226e611f59e7/code_1.71.2-1663191218_amd64.deb

# open permissions wide for apt
chmod 777 code_1.71.2-1663191218_amd64.deb

# install vscode
sudo apt install ./code_1.71.2-1663191218_amd64.deb -y

# remove vscode installer
rm code_1.71.2-1663191218_amd64.deb

