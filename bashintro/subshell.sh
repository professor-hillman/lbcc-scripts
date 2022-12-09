#!/bin/bash

# FILES=`ls`

# LASTFILE=$(ls -l | tail -1 | cut -d' ' -f10)

LASTFILE=$(ls -l | tail -1 | awk '{print $NF}')

echo "$LASTFILE"