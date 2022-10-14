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
documentation](https://scikit-learn.org/stable/modules/model_evaluation.html#average). You can log your results in a table (see [template](ResultsTable.csv)).

## EXTRA: Parallel evaluation

Evaluation on a large number of documents can take a long time. You can speed this
up by making use of parallel processing, especially if your computer has many
[CPU cores](https://www.tomshardware.com/news/cpu-core-definition,37658.html).
This means that the documents used in evaluation will be split between the available
CPU cores and each individual core has less work to do.

Most laptops have either 2 or 4 CPU cores (4 or 8 threads, as usually they support two
execution threads per core). There is some overhead involved in parallel processing, so
using two cores instead of one (the default) will not help a lot, but with four or more 
cores, the speedup can be significant.

To find out how many CPU cores and threads your machine has, here are instructions for
[Linux](https://www.cyberciti.biz/faq/check-how-many-cpus-are-there-in-linux-system/)
and another guide for both [Windows and Mac](https://www.howtogeek.com/762125/how-to-see-how-many-cores-your-processor-has/).

### Adjusting CPU cores in VirtualBox

If you are using the VirtualBox image and have more than two CPU cores available, the 
virtual machine running inside will still be limited to two CPU cores unless you change the
settings. To do this, first shut down the virtual machine. Then open the Settings view of
the machine and increase the number of CPU cores under System -> Processor. Finally start
the machine again and it should now have access to more cores. You can verify this using the
guide linked above.

### Running evaluation in parallel

To run evaluation in parallel, simply use the `--jobs` (shorthand `-j`) parameter with the
`annif eval` command. You can either use `--jobs 4` to use a specific number of CPU cores
or `--jobs 0` to use all available CPU cores.

If you use the `yso-nlf` data set, run this command:

    annif eval --jobs 0 yso-tfidf-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval --jobs 0 stw-tfidf-en data-sets/stw-zbw/docs/test/

Congratulations, you've completed Exercise 4 and you know how well your
TFIDF project is doing in terms of quality!

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
