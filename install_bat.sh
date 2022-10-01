#!/bin/bash


# update software sources
sudo apt update

# install bat
sudo apt install bat -y

# configure alias to run with bat instead of batcat (for zsh)
echo "alias bat=batcat" >> ~/.zsh_aliases

# initialize alias updates
source ~/.zshrc

# create heredoc test script
cat << EOF > hello.py
#!/usr/bin/env python3
print('Batcat installed correctly!)
EOF

# test bat install and alias
bat hello.py

# remove test script
rm hello.py

# provide feedback
printf '\n[+] If the short Python script above has syntax highlighting, bat is installed properly!'
