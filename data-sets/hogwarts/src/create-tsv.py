#!/usr/bin/env python3

import sys
import random

VOCABFILE = 'hogwarts-houses-vocab.tsv'

houses = {}
with open(VOCABFILE) as vf:
    for line in vf:
        uri, name = line.strip().split('\t')
        houses[uri] = name

namedata = []

for uri, house_name in houses.items():
    housefn = house_name.lower() + ".txt"
    with open(housefn) as names:
        for name in names:
            namedata.append("{}\t{}".format(name.strip(), uri))

random.shuffle(namedata)
for nameline in namedata:
    print(nameline)
