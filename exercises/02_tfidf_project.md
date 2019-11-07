# Exercise 2: Set up and train a TFIDF project

Annif requires you to set up one or more **projects** before you can use it.
A project is a set of configuration settings and (usually) some data files
such as a trained machine learning model. A project is identified by a
**project id**, which is typically a short string such as "yso-tfidf-en".

Projects are defined in a configuration file called `projects.cfg`. Annif
looks for a `projects.cfg` file in the current working directory unless you
tell it otherwise using either the `-p` command line option or the
`ANNIF_PROJECTS` environment variable. For the rest of this tutorial, we
will be using a working directory.

In this lesson, we will set up the simplest kind of Annif project, which
uses a TFIDF model, which needs to be trained on example documents and/or
metadata records before it can be used. 

You need to choose which data set you want to use: either the
[yso-finna-theses](../data-sets/yso-finna-theses) data set from the National
Library of Finland or the [stw-zbw](../data-sets/stw-zbw) data set from ZBW.
Either one will work, but you need to be consistent.

## 1. Create a working directory

Create a directory/folder for this tutorial in a place convenient for you
(for example under your home directory). Name it `annif-tutorial`

## 2. Create a `projects.cfg` file

Use a text editor to create a `projects.cfg` file within the working
directory.

If you use the `yso-finna-theses` data set, use the following contents:

    [yso-tfidf-en]
    name=YSO TFIDF project
    language=en
    backend=tfidf
    vocab=yso-en
    analyzer=snowball(english)

If you use the `stw-zbw` data set, use the following contents:

    [stw-tfidf-en]
    name=STW TFIDF project
    language=en
    backend=tfidf
    vocab=stw-en
    analyzer=snowball(english)

## 3. Test that Annif can read the `projects.cfg` file

On the CLI, go to the tutorial directory (where you put the `projects.cfg`
file) and run this command:

    annif list-projects

You should see a list with one entry, which is your defined project.

## 4. Load the vocabulary

Annif needs to know the vocabulary to use. We will load it from a SKOS file.

If you use the `yso-finna-theses` data set, run this command:

    annif loadvoc yso-tfidf-en data-sets/yso-finna-theses/yso-ysoplaces-cicero-skos.ttl

If you use the `stw-zbw` data set, run this command:

    annif loadvoc stw-tfidf-en data-sets/stw-zbw/stw-skos.ttl

This should take a minute or two. No output means the operation was
succesful.

You only have to do this once for a particular vocabulary. You can now reuse
the same vocabulary (by using the same `vocab=` value) in other projects.

## 5. Train the project using sample data

Now we can train the project. We will use training files that contain titles
and subjects extracted from metadata records (around 2 million for
`yso-finna-theses` and 1 million for `stw-zbw). However, we will first try
with just a small training file based on 100,000 records to test the
process.

If you use the `yso-finna-theses` data set, run this command:

    annif train yso-tfidf-en data-sets/yso-finna-theses/yso-cicero-finna-eng-small.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz-small.tsv.gz

Training should take around a minute.

## 6. Test the project

Once training is completed, we can try the model on some example sentence.

If you use the `yso-finna-theses` data set, run this command:

    echo "Machine learning algorithms build a mathematical model based on sample data" | annif suggest yso-tfidf-en

If you use the `stw-zbw` data set, run this command:

    echo "Machine learning algorithms build a mathematical model based on sample data" | annif suggest stw-tfidf-en

You can of course try any sentence or even just a single word.

## 7. Train the project using the full training data

Now that the basic model works, you can retrain it using the complete
training data sets. This should take around 10 minutes.

If you use the `yso-finna-theses` data set, run this command:

    annif train yso-tfidf-en data-sets/yso-finna-theses/yso-cicero-finna-eng.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz.tsv.gz

After retraining, you can try the `suggest` command again.

Congratulations, you've completed Exercise 2 and you have a working project!
