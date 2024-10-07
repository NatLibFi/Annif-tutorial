# Optional exercise: Custom corpus

In this lesson we will look at how to make a corpus to use with Annif.

## 1. Introduction to subject and document corpus formats
The Merriam-Webster Dictionary defines a corpus as "all the writings or works of a particular kind or on a particular subject" or a "collection or body of knowledge or evidence".
Various corpora are widely used in language and literature research. In this case we use the term to refer to a data collection used to train or evaluate Annif models.

For training Annif projects two document corpus formats are supported: one for full-text or longer documents and another for metadata or very short texts. Annif corpora are usually divided into three sets, train, validate and test. The training and testing corpora are used as they are named - the validation set can be used for fine-tuning model hyperparameters.

All Annif projects need a subject vocabulary, which defines the subjects available for automated indexing or classification. Typically this will be a thesaurus, a classification or a list of subject headings. Annif doesn't care much about the internal structure of a subject vocabulary, it just needs to know the URIs and preferred labels (a.k.a. terms or descriptors) of each subject/class/concept. If the vocabulary includes also notion codes, e.g. as in [UDC](https://en.wikipedia.org/wiki/Universal_Decimal_Classification), also they can be given.

### Subject vocabulary formats
#### Subject vocabulary as TSV

The simple TSV subject vocabulary format only specifies URIs and labels for concepts. The vocabulary file is UTF-8 encoded TSV (tab separated values) file with the file extension `.tsv`, where the first column contains a subject URI and the second column its label (and the optional third column the notation code). The format is the same as the extended subject file format for documents, specified below. For example:

```
<http://example.org/thesaurus/subj1>	networking
<http://example.org/thesaurus/subj2>	computer science
<http://example.org/thesaurus/subj3>	Internet Protocol	42.42
```

#### Subject vocabulary as SKOS

A subject vocabulary can also be given as a SKOS/RDF file. All common RDF serializations (i.e. those supported by rdflib) are supported, including RDF/XML, Turtle and N-Triples.

### Document corpus formats
#### Full-text document corpus
A full-text corpus is a directory containing (UTF-8 encoded) document and subject files. The document files should have `.txt` extension, and 
for each document file there should be a subject file with the same (base) name, but with the extension `.tsv` or `.key`. The main distinction between the two is whether or not subject URIs are included. 

A `.key` subject file simply lists subject labels one per line. For example:

```
networking
computer science
Internet Protocol
```

Note that the labels must exactly match the preferred labels of concepts in the subject vocabulary.


A `.tsv` subject file is otherwise similar, but it has two columns separated by a tab: the first column contains the subject URIs within angle brackets `<>` and the second column their labels. For example:

```
<http://example.org/thesaurus/subj1>	networking
<http://example.org/thesaurus/subj2>	computer science
<http://example.org/thesaurus/subj3>	Internet Protocol
```

Any additional columns beyond the first two are ignored.

When using this format, subject comparison is performed based on URIs, not the labels. Since URIs are (or should be) more persistent than labels, this ensures that subjects can be matched even if the labels have changed in the subject
vocabulary.

In this tutorial full-text corpora (e.g. the train set [`data-sets/stw-zbw/docs/train`](/data-sets/stw-zbw/docs/train), after downloading PDFs and converting them to text files) are used for evaluating models and training MLLM and NN ensemble models.

#### Short text document corpus 

A document corpus can be given in a single UTF-8 encoded TSV file. This format is especially useful for metadata about documents, when only titles are known, or for very short documents. The first column contains the text of the document (e.g. title or title + abstract) while the second column contains a whitespace-separated list of subject URIs (again within angle brackets) for that document. For example:

```
RFC 791: Internet Protocol	<http://example.org/thesaurus/subj1> <http://example.org/thesaurus/subj3>
RFC 1925: The Twelve Networking Truths	<http://example.org/thesaurus/subj1> <http://example.org/thesaurus/subj2>
Go To Statement Considered Harmful	<http://example.org/thesaurus/subj2>
```

Note that it is also possible to separate the subjects with tabs, thus creating a variable number of columns. The TSV file may be compressed using gzip compression. The compressed file must have the extension `.gz`. 

In this tutorial short-text corpora (e.g. [`/data-sets/stw-zbw/stw-econbiz.tsv.gz`](/data-sets/stw-zbw/stw-econbiz.tsv.gz)) are used for training associative models.


## 2. Create corpus
In this exercise you create a subject vocabulary and document corpus from metadata (titles and abstracts) of scientific articles. The full articles in question are deposited in the [arXiv archive](https://arxiv.org/) and the metadata set is distributed by [Kaggle](https://www.kaggle.com/Cornell-University/arxiv). The [Jupyter Notebook (data-sets/arxiv/create-arxiv-corpus.ipynb)](/data-sets/arxiv/create-arxiv-corpus.ipynb) demonstrates how to construct a subject vocabulary, and short-text document corpus from the JSON formatted metadata file.

The Jupyter Notebook software is included in the VirtualBox and Docker images for this tutorial, and you can start Jupyter Server by typing `jupyter notebook` on the command line. You may need to click the URL provided by the Server to open the Jupyter navigator view in your internet browser (if you go straight to the address http://localhost:8888 you need to give the token displayed in the terminal). From the main view you can navigate to the notebook `data-sets/arxiv/create-arxiv-corpus.ipynb`.

Run the notebook cell-by-cell by e.g. pressing `shift+enter` in every interactive block. The notebook comments explain the steps.

## 3. Use the corpus with Annif
Try setting up a project for the arXiv corpus and training and evaluating it. 

When training you will get many warnings about unknown URIs, because many documents in the training set have been assigned to categories that are now deprecated and thus are not in the subject vocabulary. Some of the deprecation cases could possibly be handled by utilizing the [information of the subsumed archives](https://github.com/arXiv/arxiv-base/blob/dc7e537a290751af95a5ffe87fb9074a932cacf5/arxiv/taxonomy/definitions.py#L272-L291) etc. details of the taxonoy, but that is beyond the scope of this exercise.

There is a [multi-label text classification task in Kaggle](https://www.kaggle.com/Cornell-University/arxiv/tasks?taskId=1757) which uses the same dataset and which you can take a look at. That task aims in predicting the general categories, not the detailed categories, so if you want to try the Kaggle task, you need to modify the notebook appropriately.

## More information

For more information, see the documentation in the Annif wiki:

* [Subject vocabulary formats](https://github.com/NatLibFi/Annif/wiki/Subject-vocabulary-formats)
* [Document corpus formats](https://github.com/NatLibFi/Annif/wiki/Document-corpus-formats)

---

<p align="center">
|
<a href="/README.md">Back to the main page »</a>
</p>
