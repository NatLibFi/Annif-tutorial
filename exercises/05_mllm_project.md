# Exercise 5: Set up and train a MLLM project

[![Video](/img/mllm-slides-1.png)](https://youtu.be/4cblDQ_HA3w)

- [slides](/presentations/mllm-slides.pdf)
- [transcript of video](/transcripts/mllm.md)

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
    vocab=yso
    analyzer=snowball(english)

If you use the `stw-zbw` data set, use the following snippet:

    [stw-mllm-en]
    name=STW MLLM project
    language=en
    backend=mllm
    vocab=stw
    analyzer=snowball(english)

## 2. Train the project

Now we can train the project. MLLM requires a relatively small number
(hundreds or at most a few thousand) of training documents, which should be
as similar as possible in structure to the documents it will later be
applied on.

We will therefore use full text documents from the train subset to train
MLLM. We will limit the number of training documents to 400 using the
`--docs-limit` parameter, because training with more documents would just
take longer without improving the results very much.

If you use the `yso-nlf` data set, run this command:

    annif train yso-mllm-en --docs-limit 400 data-sets/yso-nlf/docs/train/

If you use the `stw-zbw` data set, run this command:

    annif train stw-mllm-en --docs-limit 400 data-sets/stw-zbw/docs/train/

Training should take around 5-15 minutes.

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

Evaluation should take around 5-10 minutes. Write down the F1@5 and NDCG
scores and compare them with the scores that the TFIDF project got.

## EXTRA: Experiment with different amounts of training data

<details>
<summary>See details of extra section</summary>

In the training step above, we limited the number of documents to 400, but
there are many more documents available in the corpus. Try retraining with a 
different number of documents - smaller or larger - and see how it affects the 
time required to train the model and the evaluation results.

### Learning curves

If you do this many times with different amounts of training 
documents, you can plot the results into a diagram. This is called a 
[learning curve](https://en.wikipedia.org/wiki/Learning_curve_(machine_learning)) 
and it shows the relationship between the amount of training data and the evaluation
score. Typically, the curve will eventually reach a plateau, at which point any
additional training data will not substantially improve the results. This kind of
analysis will help inform decisions about how much training data to collect and use.

### Automating the experiment

To create a learning curve, you need to perform many training and evaluation
iterations. Doing this manually can be a chore, but with a bit of scripting, we can
automate it. Here is a little `bash` shell script that will step through the
different amounts of train documents and then train and evaluate the resulting
models:

```bash
#!/bin/bash

# print a usage message if parameters are missing
if (( $# != 6 )); then
        print "usage: $0 <project-id> <trainset> <testset> <minlimit> <maxlimit> <step>"
        exit 1
fi

project=$1
trainset=$2
testset=$3
minlimit=$4
maxlimit=$5
step=$6

for (( limit=$minlimit; limit<=$maxlimit; limit+=$step )); do
    echo "limit: $limit"
    time annif train $project --docs-limit $limit $trainset
    time annif eval $project $testset
    echo
done
```

To use this script, save it as `train-eval-limits.sh` and make sure it is 
executable (run the command `chmod +x train-eval-limits.sh`). Then you can it
with a command like this for the `yso-nlf` data set:

    ./train-eval-limits.sh yso-mllm-en data-sets/yso-nlf/docs/train/ data-sets/yso-nlf/docs/test/ 200 1000 200 | tee train-eval-limits.out

and similarly for the `stw-zbw` data set:

    ./train-eval-limits.sh stw-mllm-en data-sets/stw-zbw/docs/train/ data-sets/stw-zbw/docs/test/ 200 1000 200 | tee train-eval-limits.out

The commands above provide the script with all the six(!) parameters it needs: 
the project ID, the training set path, the test set path, the minimum and maximum 
limits, and the step size. With the above parameters, it will perform five train/eval 
cycles with the `docs-limit` set to 200, 400, 600, 800 and 1000 respectively. The 
output of the script, including the evaluation results, will be stored into the file
`train-eval-limits.out` in addition to being printed on the console in real time.
Running this script can take a long time (an hour or two), depending on the number
of iterations, the limit values and the size of the test set.

To analyze the results, you can use the `grep` command to extract just the numbers you
need from the output file. To get the sequence of limit values, use a command like
this to extract them from the output:

    grep limit: train-eval-limits.out | cut -d ' ' -f 2

To extract just the F1@5 scores corresponding to the limit values, use a command
like this:

    grep F1@5 train-eval-limits.out | cut -c32-

Paste both columns side by side into a spreadsheet table, like this:

| limit | F1@5                |
| ----- | ------------------- |
| 200   | 0.3170204745341874  |
| 400   | 0.34323561922389234 |
| 600   | 0.35361283894005663 |
| 800   | 0.360568593082306   |
| 1000  | 0.3660707186808946  |

Then plot the numbers as a line graph so that you have limit values on the X axis
and corresponding F1@5 scores on the Y axis, like this:

![learning curve plot](/img/learning-curve.png)

This plot shows that the F1@5 score achieved by the MLLM algorithm is increasing 
all the way up to 1000 training documents, although the increase in scores is starting
to peter out. For an optimal result, more than 1000 documents would be needed.

The chart above was created using the XY (Scatter) chart type in LibreOffice Calc.

</details>                                         
                                         
---

Congratulations, you've completed Exercise 5, you have a working MLLM project
and you know how well it performs compared to the TFIDF project!

## More information

For more information, see the documentation in the Annif wiki:

* [Backend: MLLM](https://github.com/NatLibFi/Annif/wiki/Backend%3A-MLLM)

---

<p align="center">
|
<a href="/README.md">Back to the main page »</a>
</p>
