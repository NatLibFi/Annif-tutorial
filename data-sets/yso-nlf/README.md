# yso-finna-theses data set for Annif tutorial

This directory contains the yso-finna-theses example data set that can be
used to complete the Annif tutorial. It consists of the following files and
directories:

* General Finnish Ontology YSO (version 2019.3 Cicero) plus YSO-Places
  * [yso-en.tsv](yso-ysoplaces-cicero-en.tsv) TSV format, 
    English labels and URIs only
  * [yso-skos.ttl](yso-ysoplaces-cicero-skos.ttl) SKOS
    format, including all languages (fi, sv, en) and structural information
* Training data set based on metadata records from the Finna.fi discovery
  service
  * [yso-finna.tsv.gz](yso-cicero-finna-eng.tsv.gz) TSV format,
    ca. 2 million rows, gzipped (90 MB)
  * [yso-finna-small.tsv.gz](yso-cicero-finna-eng.tsv.gz) small
    subset of the above for testing, with 100,000 rows, gzipped (5 MB)
* Example documents: English language Master's and doctoral theses from the
  University of Jyväskylä (JYX repository)
  * See [docs](docs) subdirectory for details

