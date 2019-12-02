# stw-zbw data set for Annif tutorial

This directory contains the stw-zbw example data set that can be
used to complete the Annif tutorial. It consists of the following files and
directories:

* STW thesaurus for economics in version 9.06
  * [stw-en.tsv](stw-en.tsv) TSV format, 
    English labels and URIs only
  * [stw-skos.ttl](stw-skos.ttl) SKOS
    format, including all languages (en, de) and structural information
* Training data set based on metadata records from the [EconBiz](https://www.econbiz.de) discovery
  service
  * [stw-econbiz.tsv.gz](stw-econbiz.tsv.gz) TSV format,
    ca. 1 million rows, gzipped (53M)
  * [stw-econbiz-small.tsv.gz](stw-econbiz-small.tsv.gz) small subset of the above for testing, with 100,000 rows, gzipped
* Example documents: Working papers in economics
  * See [docs](docs) subdirectory for details

## Licensing

The STW thesaurus for economics is developed by ZBW - Leibniz Information Centre for Economics.
It is licensed under the Open Database License (ODbL) v1.0.

The ZBW training data set is licensed under the CC0 1.0 Universal Public Domain Dedication.
The data sets reproduced here are based on information from a data dump underlying the ZBW search portal [EconBiz](https://www.econbiz.de/).
