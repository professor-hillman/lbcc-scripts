#!/usr/bin/env python3

from sys import argv
import urllib.parse

cmd = argv[1]

print(urllib.parse.quote(cmd))
