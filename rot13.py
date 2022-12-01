#!/usr/bin/env python3

import sys
import string
from collections import deque
from functools import cache


class Rot13:

	def __init__(self, text):
		self.text = text
		self.length = len(text)
		self.mappings = self.get_mappings()

	def rotate(self, amount=13):
		mappings = self.mappings.get(amount)
		result = ''
		for c in self.text:
			result += mappings.get(c, c)
		return result

	def bruteforce(self, offset=0, length=None):
		length = length or self.length
		for amt, mapping in self.mappings.items():
			print(f'Amount = {amt:>2}: {self.rotate(amt)[offset:offset+length]}')

	def autosolve(self, wordfile='/usr/share/wordlists/american-english'):
		wordlist = Wordlist(wordfile)
		results = []
		for amt, mapping in self.mappings.items():
			percent = wordlist.percent_in_list((decoded := self.rotate(amt)).split())
			results.append((percent, decoded))
		print(sorted(results, reverse=True)[0][1])

	def get_mappings(self):
		uppers = string.ascii_uppercase
		lowers = string.ascii_lowercase
		urotated = deque(uppers)
		lrotated = deque(lowers)

		mappings = {}
		for i in range(1, 26):
			urotated.rotate(-1)
			lrotated.rotate(-1)
			umap = dict(zip(uppers, urotated))
			lmap = dict(zip(lowers, lrotated))
			mappings.update({i: umap | lmap})

		return mappings


class Wordlist:

	def __init__(self, filename=None):
		if filename:
			with open(filename) as f:
				self.words = set(f.read().splitlines())
		else:
			self.words = set()

	def __contains__(self, words):
		if isinstance(words, str):
			return self.is_in_list(words)
		else:
			return self.all_in_list(words)

	def add_words(self, words):
		if isinstance(words, str):
			self.words.add(words)
		else:
			self.words |= set(words)

	def add_wordfile(self, filename=None):
		with open(filename) as f:
			self.words |= set(f.read().splitlines())

	def lowercase(self):
		return set(word.lower() for word in self.words)

	def uppercase(self):
		return set(word.upper() for word in self.words)

	@cache
	def is_in_list(self, word):
		return word.lower() in map(str.lower, self.words)

	def all_in_list(self, words):
		return all(map(self.is_in_list, words))

	def percent_in_list(self, words):
		if isinstance(words, str):
			return float(100 if self.is_in_list(words) else 0)
		else:
			return sum(map(self.is_in_list, words)) / len(words) * 100


def main():
	if len(sys.argv) != 3 or sys.argv[1] not in ('-b', '-a'):
		print(f'Bruteforce Usage: {sys.argv[0]} -b STRING')
		print(f'Autosolver Usage: {sys.argv[0]} -a STRING')
		sys.exit(1)

	option, string = sys.argv[1:]

	rot = Rot13(string)

	if option == '-b':
		rot.bruteforce()
	else:
		rot.autosolve()


if __name__ == '__main__':
	main()
