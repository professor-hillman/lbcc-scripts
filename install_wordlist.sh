#!/bin/bash


DESTINATION='/usr/share/wordlists/american-english'

# copy american english wordlist to standard wordlists folder
sudo cp ./wordlists/american-english ${DESTINATION}

echo "Wordlist Copied To: ${DESTINATION}"
