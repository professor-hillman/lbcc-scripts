#!/usr/bin/env python3

from sys import argv
import urllib.parse

src = argv[1]

print(urllib.parse.unquote_plus(src))
