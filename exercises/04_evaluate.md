# Exercise 4: Evaluating quality on document corpora

Testing on short text snippes only gives a first impression of the quality
of automated subject indexing. To gain a better understanding of how well
the Annif models work on real documents, we must test on a collection of
real, manually indexed documents and compare how well the subjects suggested
by the algorithm match the human-assigned ones.

The most important measures for automated subject indexing are [precision
and recall](https://en.wikipedia.org/wiki/Precision_and_recall), [F1
score](https://en.wikipedia.org/wiki/F1_score) and
[NDCG](https://en.wikipedia.org/wiki/Discounted_cumulative_gain).

We will use full text documents to evaluate the TFIDF project that
was created in the previous exercises. For the
`yso-nlf` data set, we will use 300 Master's and doctoral
theses in the
[`yso-nlf/docs/test/`](../data-sets/yso-nlf/docs/test)
directory. For the `stw-zbw` data set, we will use around 600 articles
in the corresponding
[`stw-zbw/docs/test/`](../data-sets/stw-zbw/docs/test)directory.

## 1. Evaluate TFIDF project on a collection of documents

Note that you need to have fetched the full-text documents as done in the end of [Excercise 2](02_tfidf_project.md#7-test-on-an-example-document).

If you use the `yso-nlf` data set, run this command:

    annif eval yso-tfidf-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-tfidf-en data-sets/stw-zbw/docs/test/

This will take around 5 minutes but in the end you will receive a report of
the evaluation results. Write down the values, especially `F1@5` and `NDCG`.
For more insights on the details on the different ways to compute the averaged metrics see for example [scikit-learn 
documentation](https://scikit-learn.org/stable/modules/model_evaluation.html#average).

Congratulations, you've completed Exercise 4 and you know how well your
TFIDF project is doing in terms of quality!

---

<p align="center">
<a href="/exercises/03_web_ui.md">« Previous</a> |
<a href="/exercises/05_maui_project.md">Next »</a>
</p>
