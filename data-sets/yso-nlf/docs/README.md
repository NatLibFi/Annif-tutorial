# Theses from University of Jyväskylä

This directory contains a corpus of 2066 English language Master's and
doctoral theses published in the years 2010 to 2017, collected from the
[University of Jyväskylä digital repository JYX](https://jyx2.jyu.fi).

Only the URLs and subject metadata are stored in this Git repository. Actual
PDF documents must be downloaded separately, as they are copyrighted by the
original authors. They may be downloaded from JYX under the following
condition that applies to each document:

> This publication is copyrighted. You may download, display and print it for Your own personal use. Commercial use is prohibited.

## Retrieving the PDFs

You can fetch the PDF files using the Makefile:

    make -k pdf

This requires the `wget` utility. To download more than one document at a time,
add the `-jN` option, where `N` specifies the number of jobs to run
simultaneously (e.g. `make -j8 pdf` will download 8 documents in parallel).
The `-k` option means "keep going", i.e., don't stop if there is a problem
downloading an individual file.

## Converting the PDFs to text

You can convert the fetched PDF files to text files using the Makefile:

    make -k txt

This requires the `pdftotext` utility. To convert more than one document at a time,
add the `-jN` option, where `N` specifies the number of jobs to run
simultaneously (e.g. `make -j4 txt` will convert 4 documents in parallel).
