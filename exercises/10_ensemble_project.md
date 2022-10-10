# Exercise 10: Set up and train a simple ensemble

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
    vocab=yso
    sources=yso-tfidf-en,yso-mllm-en:2

If you use the `stw-zbw` data set, use the following snippet:

    [stw-ensemble-en]
    name=STW ensemble project
    language=en
    backend=ensemble
    vocab=stw
    sources=stw-tfidf-en,stw-mllm-en:2

The `sources` setting lists the projects which will be included in the
ensemble. The sources may be given weights: in the above examples, the MLLM
project has been given twice the normal weight, because it generally gives
better results than TFIDF and is therefore more important.

If you have created an Omikuji project (see Exercise 8), you can include it
as a source as well.

## 2. Test the project on sample text

We can test the ensemble on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest yso-ensemble-en

If you use the `stw-zbw` data set, run this command:

    echo "ensemble methods use multiple learning algorithms to obtain better predictive performance" | annif suggest stw-ensemble-en

## 3. Test the project on an example document

Try asking for subject suggestions from the ensemble project to the same
document that you used in Exercise 2 (TFIDF project).

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-ensemble-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-ensemble-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this ensemble project.

## 4. Evaluate the ensemble project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-ensemble-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around 5-10 minutes. Take note of the F1@5 and NDCG
measures you got and compare them with the previous figures from TFIDF and
MLLM projects. Which one works best?

Congratulations, you've completed Exercise 6! You have a working ensemble
project and you know how well it works compared to the projects it is based on.

---

<p align="center">
<a href="/exercises/05_mllm_project.md">« Previous</a> |
<a href="/exercises/07_rest_api.md">Next »</a>
</p>
