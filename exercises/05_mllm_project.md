# Exercise 5: Set up and train a MLLM project

In this lesson, we will set up a MLLM project. MLLM is an algorithm for
lexical automated subject indexing, i.e. matching terms in document text to
terms in a controlled vocabulary. It is inspired by the Maui algorithm, but
implemented in Python within Annif.

## 1. Define a MLLM project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

If you use the `yso-nlf` data set, use the following snippet:

    [yso-mllm-en]
    name=YSO MLLM project
    language=en
    backend=mllm
    vocab=yso-en
    analyzer=snowball(english)

If you use the `stw-zbw` data set, use the following snippet:

    [stw-mllm-en]
    name=STW MLLM project
    language=en
    backend=mllm
    vocab=stw-en
    analyzer=snowball(english)

## 2. Train the project

Now we can train the project. MLLM requires a relatively small number
(hundreds or at most a few thousand) of training documents, which should be
as similar as possible in structure to the documents it will later be
applied on.

We will therefore use full text documents to train MLLM. For the
`yso-nlf` data set, we will use around 350 Master's and doctoral
theses in the
[`yso-nlf/docs/validate/`](../data-sets/yso-nlf/docs/validate)
directory. For the `stw-zbw` data set, we will use around 600 articles
in the corresponding
[`stw-zbw/docs/validate/`](../data-sets/stw-zbw/docs/validate)directory.

If you use the `yso-nlf` data set, run this command:

    annif train yso-mllm-en data-sets/yso-nlf/docs/validate/

If you use the `stw-zbw` data set, run this command:

    annif train stw-mllm-en data-sets/stw-zbw/docs/validate/

Training should take around a minute.

## 3. Test the project on sample text

Once training is completed, we can try the model on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest yso-mllm-en

If you use the `stw-zbw` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest stw-mllm-en

## 4. Test the project on an example document

Try asking for subject suggestions from the MLLM project to the same
document that you used in Exercise 2 (TFIDF project).

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-mllm-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-mllm-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this MLLM based project.

## 5. Evaluate the project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-mllm-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-mllm-en data-sets/stw-zbw/docs/test/

Evaluation should take 1-2 minutes. Write down the F1@5 and NDCG scores and
compare them with the scores that the TFIDF project got.

Congratulations, you've completed Exercise 5, you have a working MLLM project
and you know how well it performs compared to the TFIDF project!

---

<p align="center">
<a href="/exercises/04_evaluate.md">« Previous</a> |
<a href="/exercises/06_ensemble_project.md">Next »</a>
</p>
