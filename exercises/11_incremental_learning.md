# Exercise 11: Incremental learning

In this lesson, we will fine-tune the neural network ensemble by giving it
some more training data to learn from. In the previous exercise, we used the
`train` subset of the training documents for initial training. We will
continue the training using the `validate` subset, which the neural network
has not encountered yet. The `learn` command will be used for this; it
allows continuing the training without starting from scratch. Not all Annif
backends support it, but the `nn_ensemble` backend does. For
projects/backends that support learning, it can be done either via the
command line or by using the `learn` method in the REST API.

## 1. Learn from additional documents

For the `yso-nlf` data set, we will use around 350 Master's and doctoral
theses in the
[`yso-nlf/docs/validate/`](../data-sets/yso-nlf/docs/validate)
directory. For the `stw-zbw` data set, we will use around 600 articles
in the corresponding
[`stw-zbw/docs/validate/`](../data-sets/stw-zbw/docs/validate) directory.

If you use the `yso-nlf` data set, run this command:

    annif learn yso-nn-ensemble-en data-sets/yso-nlf/docs/validate/

If you use the `stw-zbw` data set, run this command:

    annif learn stw-nn-ensemble-en data-sets/stw-zbw/docs/validate/

Learning takes around 15-25 minutes.

## 2. Reevaluate the NN ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-nn-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-nn-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around 15-20 minutes.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from other kinds of projects. Did the NN ensemble improve
when given additional training documents?

Congratulations, you've completed Exercise 11! You know how to perform
incremental learning.
