#!/usr/bin/env python

# Fetch the "20 Newsgroups" dataset that is conveniently accessible via sklearn
# and convert it to Annif vocabulary & document corpus format

from sklearn.datasets import fetch_20newsgroups

def convert_to_annif_vocab(dataset, outfile):
    with open(outfile, 'w') as outf:
        for groupname in dataset.target_names:
            print("<news:{}>\t{}".format(groupname, groupname), file=outf)

def convert_to_annif_corpus(dataset, outfile):
    with open(outfile, 'w') as outf:
        for text, groupid in zip(dataset.data, dataset.target):
            text = ' '.join(text.split())  # convert all whitespace to plain spaces
            groupname = dataset.target_names[groupid]
            print("{}\t<news:{}>".format(text, groupname), file=outf)
    
newsgroups_train = fetch_20newsgroups(subset='train',
                                      remove=('headers', 'footers', 'quotes'))
newsgroups_test  = fetch_20newsgroups(subset='test',
                                      remove=('headers', 'footers', 'quotes'))

convert_to_annif_vocab(newsgroups_train, '20news-vocab.tsv')
convert_to_annif_corpus(newsgroups_train, '20news-train.tsv')
convert_to_annif_corpus(newsgroups_test, '20news-test.tsv')
