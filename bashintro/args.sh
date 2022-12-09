#!/bin/bash

SCRIPT_NAME=$0

ARG1=$1
ARG2=$2

ARGS=$@

NUMARGS=$#

echo "The name of my script is $SCRIPT_NAME"
echo "Argument 1 was $ARG1"
echo "Argument 2 was $ARG2"
echo "You passed $NUMARGS arguments to this script!"
echo "All arguments are: $ARGS"