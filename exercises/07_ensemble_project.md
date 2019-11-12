# Exercise 7: Set up and train a simple ensemble

In this lesson, we will set up a simple ensemble which combines results from
the projects set up in previous exercises.

## 1. Define an ensemble project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

If you use the `yso-nlf` data set, use the following snippet:

    [yso-ensemble-en]
    name=YSO ensemble project
    language=en
    backend=ensemble
    vocab=yso-en
    sources=yso-tfidf-en,yso-maui-en,yso-fasttext-en

If you use the `stw-zbw` data set, use the following snippet:

    [stw-ensemble-en]
    name=STW ensemble project
    language=en
    backend=ensemble
    vocab=stw-en
    sources=stw-tfidf-en,stw-maui-en,stw-fasttext-en

The `sources` setting lists the projects which will be included in the
ensemble.

## 2. Test the project

We can test the ensemble on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest yso-ensemble-en

If you use the `stw-zbw` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest stw-ensemble-en

You can also try the Web UI with this ensemble project.

## 5. Evaluate the ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around X minutes for `yso-nlf` and around X minutes
for `stw-zbw`.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from TFIDF, Maui and fastText projects. Which one works best?

Congratulations, you've completed Exercise 7! You have a working ensemble
project and you know how well it works compared to the projects it is based on.
