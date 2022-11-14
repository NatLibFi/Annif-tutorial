This directory contains the [20 Newsgroups](http://qwone.com/~jason/20Newsgroups/)
dataset, pre-converted into Annif vocabulary and document corpus format.

The script used for conversion is also available. It makes use of the
scikit-learn
[fetch_20newsgroups](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.fetch_20newsgroups.html)
function which is a convenient way of accessing the dataset.

This is the `bydate` flavor of the dataset, which has been split into
`train` (n=11314) and `test` (n=7532) subsets by date. All header
information as well as quote headers, which could provide non-topical hints about
the newsgroup a message was posted in, have been stripped.
