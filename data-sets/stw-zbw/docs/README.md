# Working Papers in Economics from EconStor

This directory contains a corpus of 4200 working papers in Economics from
the Open Access repository [EconStor](https://www.econstor.eu). They are
divided into train (70%), validation (15%) and test (15%) folds.

Only the URLs and subject metadata are stored in this Git repository. Actual
PDF documents must be downloaded separately, as they may be copyrighted by the
original authors. They can be downloaded under the following
condition that applies to all documents in EconStor:

> Terms of Use: Documents in EconStor may be saved and copied for your personal and scholarly purposes.

> You are not to copy documents for public or commercial purposes, to exhibit the documents publicly, to make them publicly available on the internet, or to distribute or otherwise use the documents in public.

> If the documents have been made available under an Open Content Licence (especially Creative Commons Licences), you may exercise further usage rights as specified in the indicated licence.

## Retrieving the PDFs

You can fetch the PDF files using the Makefile:

    make pdf

This requires the `wget` utility. To download more than one document at a time,
add the `-jN` option, where `N` specifies the number of jobs to run
simultaneously (e.g. `make -j8 pdf` will download 8 documents in parallel).

## Converting the PDFs to text

You can convert the fetched PDF files to text files using the Makefile:

    make txt

This requires the `pdftotext` utility. To convert more than one document at a time,
add the `-jN` option, where `N` specifies the number of jobs to run
simultaneously (e.g. `make -j4 txt` will convert 4 documents in parallel).
