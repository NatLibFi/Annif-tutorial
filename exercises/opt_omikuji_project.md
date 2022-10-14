# Optional exercise: Set up and train an Omikuji project

In this lesson, we will set up an Omikuji project.
[Omikuji](https://github.com/tomtung/omikuji) is an implementation of a family of tree-based machine learning algorithms for extreme multilabel classification. 
With Omikuji it is possible to build models that emulate (for example) [Parabel](https://doi.org/10.1145/3178876.3185998), [Bonsai](https://arxiv.org/abs/1904.08249), or [AttentionXML](https://arxiv.org/abs/1811.01727) algorithms. 
The quality of results these algorithms produces is generally very good, even without tuning of hyperparameters. Training can be computationally intensive; by default it will use all available CPU cores in parallel during the training phase. Also large amounts of RAM (several GB) may be required during training, but during use the memory usage is lower.

Note that if you have a local installation of Annif, you will first need to install the 
[optional Omikuji dependencies](https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies#omikuji-backend).

We will create a project and train it with the same document titles and
subjects that we used for the TFIDF project.

## 1. Define an Omikuji project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file. 

If you use the `yso-nlf` data set, use the following snippet:

    [yso-omikuji-parabel-en]
    name=Omikuji Parabel English
    language=en
    backend=omikuji
    analyzer=snowball(english)
    vocab=yso


If you use the `stw-zbw` data set, use the following snippet:

    [stw-omikuji-parabel-en]
    name=Omikuji Parabel English
    language=en
    backend=omikuji
    analyzer=snowball(english)
    vocab=stw


These are configurations that emulate the Parabel algorithm. All the hyperparameters are left at their default values.


## 2. Train the project using sample data

If you use the `yso-nlf` data set, run this command:

    annif train yso-omikuji-parabel-en data-sets/yso-nlf/yso-finna-small.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-omikuji-parabel-en data-sets/stw-zbw/stw-econbiz-small.tsv.gz

## 3. Test the project on sample text

Once training is completed, we can try the model on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "random fortunes written on strips of paper at Shinto shrines and Buddhist temples in Japan." | annif suggest yso-omikuji-parabel-en

If you use the `stw-zbw` data set, run this command:

    echo "random fortunes written on strips of paper at Shinto shrines and Buddhist temples in Japan." | annif suggest stw-omikuji-parabel-en

## 4. Train the project using the full training data

Now retrain it using the complete training data sets.

If you use the `yso-nlf` data set, run this command:

    annif train yso-omikuji-parabel-en data-sets/yso-nlf/yso-finna.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-omikuji-parabel-en data-sets/stw-zbw/stw-econbiz.tsv.gz

Full training should take at most around 40 minutes (on a computer with 8 CPUs).

## 5. Test the project on an example document

Try asking for subject suggestions from the Omikuji project to the same
document that you used in Exercise 2 (TFIDF project).

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-omikuji-parabel-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-omikuji-parabel-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this Omikuji based project.

## 6. Evaluate the Omikuji project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-omikuji-parabel-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-omikuji-parabel-en data-sets/stw-zbw/docs/test/

Evaluation should take around 5 minutes.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from TFIDF and Maui projects. Which one works best?

## EXTRA: Experiment with different algorithms

The project configurations above made Omikuji emulate the Parabel algorithm.
In the [Annif wiki](https://github.com/NatLibFi/Annif/wiki/Backend%3A-Omikuji#example-configuration)
there are example configurations with hyperparameters that make Omikuji emulate the Bonsai and AttentionXML algorithms.
You can try those, and compare the evaluation results.

---

Congratulations, you've completed Exercise 8! You have a working Omikuji
project and you know how well it works compared to TFIDF and MLLM.


---

<p align="center">
<a href="/exercises/07_rest_api.md">« Previous</a> |
<a href="/exercises/09_hogwarts.md">Next »</a>
</p>
