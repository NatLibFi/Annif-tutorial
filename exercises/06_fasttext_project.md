# Exercise 6: Set up and train a fastText project

In this lesson, we will set up a fastText project.
[fastText](https://fasttext.cc/) is a machine learning model for text
classification developed by Facebook Research. It has some advanced
features, such as being able to use word and character level n-grams (i.e.
words that appear together and subwords) and to creeate word embeddings. On
the downside, it has lots of tunable parameters and finding a combination
that works well on a given data set can be a challenge.

We will create a project and train it with the same document titles and
subjects that we used for the TFIDF project.

## 1. Define a fastText project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

If you use the `yso-finna-theses` data set, use the following snippet:

    [yso-fasttext-en]
    name=YSO fastText project
    language=en
    backend=fasttext
    vocab=yso-en
    analyzer=snowball(english)
    # ... TODO hyperparameters

If you use the `stw-zbw` data set, use the following snippet:

    [stw-fasttext-en]
    name=STW fastText project
    language=en
    backend=fasttext
    vocab=stw-en
    analyzer=snowball(english)
    # ... TODO hyperparameters

## 2. Train the project using sample data

If you use the `yso-finna-theses` data set, run this command:

    annif train yso-fasttext-en data-sets/yso-finna-theses/yso-cicero-finna-eng-small.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-fasttext-en data-sets/stw-zbw/stw-econbiz-small.tsv.gz

## 3. Test the project

Once training is completed, we can try the model on some example sentence.

If you use the `yso-finna-theses` data set, run this command:

    echo "library for efficient learning of word representations and sentence classification" | annif suggest yso-fasttext-en

If you use the `stw-zbw` data set, run this command:

    echo "library for efficient learning of word representations and sentence classification" | annif suggest stw-fasttext-en

You can also try the Web UI with this fastText based project.

## 4. Train the project using the full training data

Now retrain it using the complete training data sets. This should take
around 10 minutes.

If you use the `yso-finna-theses` data set, run this command:

    annif train yso-fasttext-en data-sets/yso-finna-theses/yso-cicero-finna-eng.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-fasttext-en data-sets/stw-zbw/stw-econbiz.tsv.gz

## 5. Evaluate the fastText project on a collection of documents

If you use the `yso-finna-theses` data set, run this command:

    annif eval yso-maui-en data-sets/yso-finna-theses/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-maui-en data-sets/stw-zbw/docs/test/

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from TFIDF and Maui projects. Which one works best?

Congratulations, you've completed Exercise 6! You have a working fastText
project and you know how well it works compared to TFIDF and Maui.
