Welcome to this Annif tutorial video, which presents some basic notions about the algorithms that can be used in Annif.

One major distinction that we need in order to classify these algorithms into categories is the one between lexical and associative approaches.
Lexical approaches use information from the underlying controlled vocabulary in order to identify terms in the document that match concepts in the vocabulary, and then use various text features such as tf-idf, position of first occurrence, and length in order to identify the concepts that best represent the content of this document specifically.
Associative approaches, on the other hand, use statistical features that are derived from the word sequences that occur in the input documents. That is, they only refer to the intellectually annotated training data itself in order to learn the statistical association between terms or word sequences in the input texts and concepts from the vocabulary.
Lexical and associative approaches hugely differ in the amount of training data required: Lexical algorithms either don't need any training data at all, or only a small number, that is, typically tens or hundreds of documents in total, whereas associative algorithms require several orders of magnitude more, that is, tens or hundreds of documents _per subject_.

Another notion that we will need is that of TF-IDF or “term frequency – inverse document frequency” which is based on the assumption that a term which does not occur frequently in general, that is, in the corpus, but occurs frequently in a certain document in the corpus
could indicate a subject that is relevant to the content of that document.
TF-IDF similarity as a way to compare new documents to known documents is a very simple numerical statistic which can be used to establish a baseline that more advanced machine learning methods have to meet.

You will be able to apply a TF-IDF-based machine learning algorithm to our data in one of the first exercises. 
And here is a short list of algorithms that are available in Annif, some of which you will get to know in the following exercises. Each algorithm is implemented as an Annif backend, and each backend has its own documentation page in the Annif wiki.
There are MLLM and stwfsa, which are lexical approaches and the corresponding Annif backends are improved reimplementations of earlier versions of those algorithms, and then there are various backends which incorporate associative approaches, including for example tf-idf, which we already mentioned, fastText which uses word embeddings and neural networks in order to achieve a similar performance as a deep neural network architecture, and then some algorithms from the Omikuji family which are designed to perform well even for huge sets of subjects.

This slide contains various links in case you want to dig deeper and get more background information about the different methods and technologies mentioned here.
Thank you for watching.
