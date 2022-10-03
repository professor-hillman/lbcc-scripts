#!/bin/bash

# build the docker image we need to run uncompyle6
docker build -t decompyler .

# create bash function to easily run uncompyle6 via container
echo '' >> ~/.zshrc
echo 'decompyle () {' >> ~/.zshrc
echo '    docker run --rm -v ${PWD}:/data decompyler:latest uncompyle6 "/data/$1"' >> ~/.zshrc
echo '}' >> ~/.zshrc
