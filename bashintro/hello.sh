#!/bin/bash

FNAME='Jason'
LNAME='Hillman'

AGE='46'

FN="$FNAME $LNAME"

echo "${FN:0:5}"