# Optional exercise: Automated classification

In this lesson, we will apply Annif on an automated classification task,
where the goal is to classify each document into a single class or category
from a classification with mutually exclusive classes; in machine learning
terms, this is called multiclass classification. This is different from the
kind of subject indexing performed in earlier exercises, where the goal was
to assign a small number of representative subjects for a document (also
called multi-label classification).

Classification can be seen as a tougher task, because there is only one
correct answer that the algorithm must find and there are no partially
correct answers. In the library world, this kind of setting is common with
library classifications such as the Dewey Decimal Classification and the
Universal Decimal Classification. The classifications are often used to
determine the location of books on shelves and each book needs to be placed
on exactly one shelf.

In this exercise, we will use a small toy classification called [20
Newsgroups](http://qwone.com/~jason/20Newsgroups/) instead of a large
library classification, which could include tens of thousands of classes.
The 20 Newsgroups data set is a set of messages posted to twenty Usenet
discussion groups dedicated to differnt topics - similar to mailing lists or
web forums - in the early days of the Internet. This data set is often used
to benchmark text classification algorithms. For more information about the
data set and how it was prepared for use as an Annif corpus, see the [README
file](/data-sets/20news/README.md) of the corpus files.

Not all Annif algorithms are well suited for multiclass classification. The
lexical algorithms MLLM and STWFSA rely a lot on information from the
vocabulary, such as term labels and semantic relations, but typical
classifications either don't have this information or it cannot be
effectively used by the algorithms.

We will introduce a new algorithm called SVC (Support Vector
Classification), which is a supervised learning model for classification
that is based on the idea of [support-vector
machines](https://en.wikipedia.org/wiki/Support-vector_machine). This is a
relatively lightweight associative algorithm that works very well even with
limited amounts of training data. We will also use the Omikuji backend for
comparison, another good choice for classification tasks. 

For Omikuji, we will use a Bonsai configuration (see the Omikuji exercise
for details), which is somewhat heavier to train than the basic Parabel
configuration but usually provides better results. 

## 1. Define the projects

Use a text editor to add new project definitions to the end of the
`projects.cfg` file.

    [20news-svc-en]
    name=20 Newsgroups SVC English
    language=en
    backend=svc
    analyzer=snowball(english)
    limit=100
    vocab=20news

    [20news-omikuji-bonsai-en]
    name=20 Newsgroups Omikuji Bonsai English
    language=en
    backend=omikuji
    analyzer=snowball(english)
    vocab=20news
    cluster_balanced=False
    cluster_k=100
    max_depth=3

Check that the configuration is valid:

    annif list-projects

## 2. Load the vocabulary of 20 Newsgroups

Run this command:

    annif load-vocab --language en 20news data-sets/20news/20news-vocab.tsv

The vocabulary file is small and simple, it just contains a line for each
newsgroup containing the newsgroup URI and name. Since this is a TSV file
with no language information, we need to use the `--language` option to
indicate that the subject labels (newsgroup names) are in English.

## 3. Train the SVC project

Run this command:

    annif train 20news-svc-en data-sets/20news/20news-train.tsv

Model training should take less than a minute.

## 4. Test the SVC project on an example document

First, we can take a look at the first document from the test set using this
command:

    head -n 1 data-sets/20news/20news-test.tsv

It is a message that looks like this:

> I am a little confused on all of the models of the 88-89 bonnevilles. I
> have heard of the LE SE LSE SSE SSEI. Could someone tell me the
> differences are far as features or performance. I am also curious to know
> what the book value is for prefereably the 89 model. And how much less
> than book value can you usually get them for. In other words how much are
> they in demand this time of year. I have heard that the mid-spring early
> summer is the best time to buy.	\<news:rec.autos>

The message is about cars and was posted to the `rec.autos` newsgroup, as
can be seen from the tag at the end. But this is a difficult document to
classify: the topic may not be entirely obvious from the text as it doesn't
directly mention cars. We can check what newsgroups the SVC algorithm
suggests for this text. We can pipe the text through the `cut` command in
order to strip away the tag at the end, leaving just the text, and pipe it
directly to the `annif suggest` command:

    head -n 1 data-sets/20news/20news-test.tsv | cut -f 1 | annif suggest 20news-svc-en

Is the first suggestion `rec.autos` or something else? If `rec.autos` is
not the top suggestion, how close is it to the top?

## 5. Evaluate the SVC project

We can then evaluate the model on the whole test set. Run this command:

    annif eval 20news-svc-en data-sets/20news/20news-test.tsv

Evaluation should take around a minute. Check the *Precision@1* score,
which indicates the proportion of the first suggestions of the algoritm that
are considered correct; in this kind of multiclass setting, this corresponds
to the *accuracy* of the classifier. Write down this number so you can
compare it with the results of further experiments.

## 6. Train the Omikuji Bonsai project

Run this command:

    annif train 20news-omikuji-bonsai-en data-sets/20news/20news-train.tsv

Model training should take around one minute.

## 7. Test the Omikuji Bonsai project on an example document

We can test the output of the Omikuji project just like we did for SVC
above:

    head -n 1 data-sets/20news/20news-test.tsv | cut -f 1 | annif suggest 20news-omikuji-bonsai-en

Was the top suggestion correct this time? If not, how far from the top was
the correct answer `rec.autos`?

## 8. Evaluate the Omikuji Bonsai project

Run this command:

    annif eval 20news-omikuji-bonsai-en data-sets/20news/20news-test.tsv

Evaluation should take around 1 minute. Again, check the *Precision@1* score
and compare it with the result you got from the SVC evaluation above. Which
algorithm worked better?

## EXTRA: Use bigrams for better accuracy

<details>
<summary>See details on how to use bigrams</summary>

The above defined projects relied on the default value of the `ngram`
setting, which is 1. This is a setting that affects the vectorizer, i.e. the
preprocessing of text which turns words into numeric vectors. By changing
the `ngram` setting to 2, we can instruct the vectorizer to use
[bigrams](https://en.wikipedia.org/wiki/Bigram) (pairs of consecutive words)
as well as unigrams (single words). This will extract the maximum amount of
information from the relatively short texts available and thus hopefully
improve classification accuracy, at the cost of a larger and heavier model.

Add this settings to both the SVC and Omikuji projects you added above:

    ngram=2

Then retrain and evaluate both projects. Did you get a better result? Did it
take longer and/or consume more resources?

Including bigrams can increase the size of the model quite drastically,
especially for larger vocabularies and training corpora. To keep resource
usage in control, we can also use the `min_df` setting. This will instruct
the vectorizer to ignore tokens (bigrams or unigrams) that only appear in a
small number of documents of the training set. This will reduce the number
of features and thus the size of the model and the resource consumption.

Add this settings to both the SVC and Omikuji projects so that tokens
(unigrams or bigrams) must appear in at least two documents to be
considered:

    min_df=2

Then retrain and evaluate both projects. How did this affect the result?

</details>

---

Congratulations, you've completed the classification exercise, you have performed
classification using two different algorithms and compared their results!

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
