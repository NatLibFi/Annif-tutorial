# Exercise 12: Create a custom corpus for Annif (DRAFT)

In this lesson we will look at how to make a corpus to use with Annif.

## 0. Introduction to Annif Corpora and corpora formats (in here or as slides)
The Merriam-Webster Dictionary defines a corpus as "all the writings or works of a particular kind or on a particular subject" or a "collection or body of knowledge or evidence".
Various corpora are widely used in language and literature research. In this case we use the term to refer to a data collection used to train or evaluate Annif.
Annif supports two document corpus formats: one for full-text or longer documents and another for metadata or very short texts.

### Full-text corpora
A full-text corpus is a directory containing document and subject files. The document files should have `.txt` extension, and 
for each document file there should be a subject file with the same (base) name, but with the extension `.tsv` or `.key`. The main distinction between the two is whether or not subject URIs are included. 

A  `.key`-file simply lists subject labels, UTF-8 encoded, one per line. For example:

```
networking
computer science
Internet Protocol
```

Note that the labels must exactly match the preferred labels of concepts in the subject vocabulary.


A `.tsv` file is otherwise similar, but the subject file is now a UTF-8 encoded tab separated file, where the first column contains a subject URI within angle brackets `<>` and the second column its label. For example:

```
<http://example.org/thesaurus/subj1>	networking
<http://example.org/thesaurus/subj2>	computer science
<http://example.org/thesaurus/subj3>	Internet Protocol
```

Any additional columns beyond the first two are ignored.

When using this format, subject comparison is performed based on URIs, not the labels. Since URIs are (or should be) more persistent than labels, this ensures that subjects can be matched even if the labels have changed in the subject
vocabulary.

### Short text document corpus 

A document corpus can be given in a single UTF-8 encoded TSV file. This format is especially useful for metadata about documents, when only titles are known, or for very short documents. The first column contains the text of the document (e.g. title or title + abstract) while the second column contains a whitespace-separated list of subject URIs (again within angle brackets) for that document. For example:

```
RFC 791: Internet Protocol	<http://example.org/thesaurus/subj1> <http://example.org/thesaurus/subj3>
RFC 1925: The Twelve Networking Truths	<http://example.org/thesaurus/subj1> <http://example.org/thesaurus/subj2>
Go To Statement Considered Harmful	<http://example.org/thesaurus/subj2>
```

Note that it is also possible to separate the subjects with tabs, thus creating a variable number of columns.

The TSV file may be compressed using gzip compression. The compressed file must have the extension `.gz`. Annif corpora are usually divided into three sets, train, validate and test. The training and testing corpora are used as they are named - the validation set can be used for fine-tuning model hyperparameters.

## 1. Obtain data
In this exercise we will use a corpus of scientific articles retrieved from arXiv for demonstration purposes. You can use the [Jupyter Notebook](https://github.com/NatLibFi/Annif-tutorial/blob/update-spring-2021/data-sets/arxiv/create-arxiv-corpus.ipynb) to construct a subject vocabulary and short-text document corpus.

The Jupyter Notebook software is included in the VirtualBox and Docker images for this tutorial, and you can start Jupyter Server by typing `jupyter notebook` on the command line. You may need to click the URL provided by the Server to open the Jupyter navigator view in your internet browser (if you go straight to the address http://localhost:8888 you need to give the token displayed in the terminal). From the main view you can navigate to the notebook `data-sets/arxiv/create-arxiv-corpus.ipynb`.

Run the notebook cell-by-cell by e.g. pressing `shift+enter` in every interactive block. The notebook comments explain the steps.

## 2. Use the corpus with Annif
Try training Annif with the arXiv corpora and evaluate the result. When training you will get many warnings about unknown URIs, because many documents in the training set have been assigned to categories that are now deprecated and thus are not in the subject vocabulary.

---

<p align="center">
<a href="/exercises/11_incremental_learning.md">« Previous</a> |
</p>
