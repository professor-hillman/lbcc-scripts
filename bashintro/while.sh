#!/bin/bash

NUM=0

while (( NUM <= 5 )); do
    echo "$NUM"
    NUM=$((NUM + 1))
done

# while [ $NUM -lt 5 ]; do
#     echo "$NUM"
#     ((NUM++))
# done
