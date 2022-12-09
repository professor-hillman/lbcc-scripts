#!/bin/bash

URL='http://178.62.21.211:32180/'

STRING=$(curl -s $URL -c 'cookie.txt' | grep -Po '[a-zA-Z0-9]{20}')

MD5=$(echo -n $STRING | md5sum | awk '{print $1}')

RESP=$(curl -s -X POST $URL -d "hash=${MD5}" -b 'cookie.txt')

FLAG=$(echo "$RESP" | grep -Po 'HTB{.*}')

echo $FLAG
