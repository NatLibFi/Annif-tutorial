# Exercise 10: Set up and train a neural network ensemble

In this lesson, we will set up a trainable dynamic neural network ensemble
model that intelligently combines results from the projects set up in
previous exercises. Initially (with no training), the backend behaves
exactly like a basic ensemble, but in this case the training data is used to
fine-tune the output to better match the given manually assigned subjects in
the training documents.

## 1. Define the project in the `projects.cfg` file

If you use the `yso-nlf` data set, use the following snippet:

    [yso-nn-ensemble-en]
    name=YSO neural ensemble project
    language=en
    backend=nn_ensemble
    vocab=yso-en
    sources=yso-tfidf-en,yso-maui-en
    nodes=100
    dropout_rate=0.2
    epochs=10

If you use the `stw-zbw` data set, use the following snippet:

    [stw-nn-ensemble-en]
    name=STW neural ensemble project
    language=en
    backend=ensemble
    vocab=stw-en
    sources=stw-tfidf-en,stw-maui-en
    nodes=100
    dropout_rate=0.2
    epochs=10 
    
The `sources` setting lists the projects which will be included in the
ensemble. If you have created a fastText project, you can include it as a
source as well.

## 2. Train the project

The NN ensemble can use any number of training documents, which should be as
similar as possible to the documents it will later be applied on. We will
use full text documents to train the ensemble.

For the `yso-nlf` data set, we will use around 1400 Master's and doctoral
theses in the
[`yso-nlf/docs/train/`](../data-sets/yso-nlf/docs/train)
directory. For the `stw-zbw` data set, we will use around 2900 articles
in the corresponding
[`stw-zbw/docs/train/`](../data-sets/stw-zbw/docs/train)directory.

If you use the `yso-nlf` data set, run this command:

    annif train yso-nn-ensemble-en data-sets/yso-nlf/docs/train/

If you use the `stw-zbw` data set, run this command:

    annif train stw-nn-ensemble-en data-sets/stw-zbw/docs/train/

Training should take around a minute.

## 3. Test the ensemble

We can test the ensemble on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest yso-nn-ensemble-en

If you use the `stw-zbw` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest stw-nn-ensemble-en

You can also try the Web UI with this ensemble project.

## 4. Evaluate the NN ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-nn-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-nn-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around X minutes for `yso-nlf` and around X minutes
for `stw-zbw`.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from other kinds of projects. Which one works best?

Congratulations, you've completed Exercise 10! You have a working neural ensemble
project and you know how well it works compared to the projects it is based on.
