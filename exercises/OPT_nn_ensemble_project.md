# Optional exercise: Set up and train a neural network ensemble

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
    vocab=yso
    sources=yso-tfidf-en,yso-mllm-en:2
    nodes=100
    dropout_rate=0.2
    epochs=10

If you use the `stw-zbw` data set, use the following snippet:

    [stw-nn-ensemble-en]
    name=STW neural ensemble project
    language=en
    backend=nn_ensemble
    vocab=stw
    sources=stw-tfidf-en,stw-mllm-en:2
    nodes=100
    dropout_rate=0.2
    epochs=10 
    
The `sources` setting lists the projects which will be included in the
ensemble. If you have created an Omikuji project, you can include it as a
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

Training takes around 20-30 minutes. 
Most of the time is spent on processing the training documents
with the source projects/backends; the neural network is only trained at
the very end and takes only a few minutes.

## 3. Test the ensemble on sample text

We can test the ensemble on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest yso-nn-ensemble-en

If you use the `stw-zbw` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest stw-nn-ensemble-en

## 4. Test the project on an example document

Try asking for subject suggestions from the NN ensemble project to the same
document that you used in Exercise 2 (TFIDF project).

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-nn-ensemble-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-nn-ensemble-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this NN ensemble project.

## 5. Evaluate the NN ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-nn-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-nn-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around 5-15 minutes.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from other kinds of projects. Is the NN ensemble better
than a plain ensemble?

## EXTRA: Incremental learning
<details><summary>
See details of extra section
</summary>

The neural network ensemble has an additional feature missing from most
other backends: it can continue learning from new documents after initial
training. In this extra step, we will fine-tune the neural network ensemble
by giving it some more training data to learn from.

In the exercise above,  we used the `train` subset of the training documents 
for initial training. We will continue the training using the `validate` subset,
which the neural network has not encountered yet. The `learn` command will be 
used for this; it allows continuing the training without starting from scratch. 
Not all Annif backends support it, but the `nn_ensemble` backend does. For
projects/backends that support learning, it can be done either via the
command line or by using the `learn` method in the REST API.

### Learn from additional documents

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

### Reevaluate the NN ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-nn-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-nn-ensemble-en data-sets/stw-zbw/docs/test/

Again the evaluation should take around 5-15 minutes.

Take note of the F1@5 and NDCG measures you got and compare them with the
previous figures from the initial training and evaluation. Did the NN ensemble
improve when given additional training documents?
</details>

---

Congratulations, you've completed Exercise 10! You have a working neural ensemble
project and you know how well it works compared to the projects it is based on.

## More information

For more information, see the documentation in the Annif wiki:

* [Backend: nn_ensemble](https://github.com/NatLibFi/Annif/wiki/Backend%3A-nn_ensemble)

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
