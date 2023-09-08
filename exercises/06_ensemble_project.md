# Exercise 6: Set up and train a simple ensemble

In this lesson, we will set up a simple ensemble which combines results from
the projects set up in previous exercises.
There will be two variants of the exercise. One for the `yso-nlf` data set and one for `stw-zbw`.

## `yso-nlf` ensemble

### 1. Inspect the ouptut of previous projects

Have a look at the suggestions of the mllm and tfidf projects trained in previous exercises on the input 'History of Salt Prices in Europe'.
The input is a publication title made up for this exercise.

    echo "The History of Salt Prices in Europe" | annif suggest yso-tfidf-en

When trained on the full data for the tfidf exercise (`yso-finna.tsv.gz`) the output should be similar to the following:

    <http://www.yso.fi/onto/yso/p10774>	price formation	0.4722590446472168
    <http://www.yso.fi/onto/yso/p1853>	salts	0.46669360995292664
    <http://www.yso.fi/onto/yso/p750>	prices	0.4588349163532257
    <http://www.yso.fi/onto/yso/p8765>	rock salt	0.4195999503135681
    <http://www.yso.fi/onto/yso/p2972>	price policy	0.4141332507133484
    <http://www.yso.fi/onto/yso/p15558>	sea salt	0.39660337567329407
    <http://www.yso.fi/onto/yso/p19066>	price control	0.3518404960632324
    <http://www.yso.fi/onto/yso/p15568>	land price	0.3495687246322632
    <http://www.yso.fi/onto/yso/p8192>	consumer prices	0.3393503725528717
    <http://www.yso.fi/onto/yso/p10773>	pricing	0.3355662524700165

As you can see most parts of the input are represented in the ten highest scoring suggestions.
Surprisingly [Europe](http://www.yso.fi/onto/yso/p94111) is missing.

Now check the output of the `mllm` project by entering `echo "The History of Salt Prices in Europe" | annif suggest yso-mllm-en`.
When trained as described in the mllm exercise the output should be similar to:


    <http://www.yso.fi/onto/yso/p1853>	salts	0.6944791078567505
    <http://www.yso.fi/onto/yso/p1780>	history	0.639129638671875
    <http://www.yso.fi/onto/yso/p94111>	Europe	0.2032901495695114
    <http://www.yso.fi/onto/yso/p750>	prices	0.17708998918533325
    <http://www.yso.fi/onto/yso/p10773>	pricing	0.17708998918533325

In this set of suggestions all relevant topics of the title are present.
However, [Europe](http://www.yso.fi/onto/yso/p94111) appears before price and subject matter experts may deem the topic more important than the location.
To remedy the mistakes of the individual projects we will combine them in an ensemble.

### 2. Define an ensemble project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

    [yso-ensemble-en]
    name=YSO ensemble project
    language=en
    backend=ensemble
    vocab=yso
    sources=yso-tfidf-en,yso-mllm-en:2

The `sources` setting lists the projects which will be included in the
ensemble. The sources may be given weights: in the above examples, the MLLM
project has been given twice the normal weight, because it generally gives
better results than TFIDF and is therefore more important.

If you have created an Omikuji project (see [Omikuji exercise](OPT_omikuji_project.md)), you can include it
as a source as well.

### 3. Check the output of the ensemble project

Entering `echo "The History of Salt Prices in Europe" | annif suggest yso-ensemble-en` should give you results similar to:

    <http://www.yso.fi/onto/yso/p1853>	salts	0.6185505986213684
    <http://www.yso.fi/onto/yso/p1780>	history	0.5137295722961426
    <http://www.yso.fi/onto/yso/p750>	prices	0.27100497484207153
    <http://www.yso.fi/onto/yso/p10773>	pricing	0.22991541028022766
    <http://www.yso.fi/onto/yso/p94111>	Europe	0.2286493331193924
    <http://www.yso.fi/onto/yso/p10774>	price formation	0.15741968154907227
    <http://www.yso.fi/onto/yso/p8765>	rock salt	0.1398666501045227
    <http://www.yso.fi/onto/yso/p2972>	price policy	0.13804441690444946
    <http://www.yso.fi/onto/yso/p15558>	sea salt	0.13220112025737762
    <http://www.yso.fi/onto/yso/p19066>	price control	0.11728016287088394

In the combined output all relevant parts of the title are present and [Europe](http://www.yso.fi/onto/yso/p94111) has a lower score than [prices](http://www.yso.fi/onto/yso/p750) and [pricing](http://www.yso.fi/onto/yso/p10773).

### 4. Test the project on an example document

Try asking for subject suggestions from the ensemble project to the same
document that you used in Exercise 2 (TFIDF project).

    annif suggest yso-ensemble-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

You can also try the Web UI with this ensemble project.

## 5. Evaluate the ensemble project on a collection of documents

You can generate evaluation metrics on the ensemble project by running

    annif eval yso-ensemble-en data-sets/yso-nlf/docs/test/

Evaluation should take around 5-10 minutes. Take note of the F1@5 and NDCG
measures you got and compare them with the previous figures from TFIDF and
MLLM projects. Which one works best?

Congratulations, you've completed Exercise 6 for the `yso-nlf` data set! You have a working ensemble
project and you know how well it works compared to the projects it is based on.

## `stw-zbw` ensemble

### 1. Inspect the ouptut of previous projects

Have a look at the suggestions of the mllm and tfidf projects trained in previous exercises on the input 'History of Salt Prices in Europe'.
The input is a publication title made up for this exercise.

    echo "The History of Salt Prices in Europe" | annif suggest stw-tfidf-en

When trained on the full data for the tfidf exercise (`stw-econbiz.tsv.gz`) the output should be similar to the following:

    <http://zbw.eu/stw/descriptor/14205-5>	Salt	0.7533037066459656
    <http://zbw.eu/stw/descriptor/26500-1>	Mongolians	0.28582242131233215
    <http://zbw.eu/stw/descriptor/10213-5>	Price	0.2692473828792572
    <http://zbw.eu/stw/descriptor/11519-4>	Price level	0.2639395296573639
    <http://zbw.eu/stw/descriptor/12794-5>	Pricing strategy	0.2634529173374176
    <http://zbw.eu/stw/descriptor/10978-5>	Price regulation	0.2628745436668396
    <http://zbw.eu/stw/descriptor/15104-6>	Price statistics	0.26096075773239136
    <http://zbw.eu/stw/descriptor/10217-4>	Price theory	0.2585664391517639
    <http://zbw.eu/stw/descriptor/19224-4>	Regional price index	0.25058141350746155
    <http://zbw.eu/stw/descriptor/15706-6>	Economic history	0.2350277602672577

Surprisingly [Mongolians](http://zbw.eu/stw/descriptor/26500-1) is found in the ten best suggestions.
It is possible that the algorithm relates [Salt](http://zbw.eu/stw/descriptor/14205-5) to [Mongolians](http://zbw.eu/stw/descriptor/26500-1) due to skew in the training data.
Additionally the concept [Europe](http://zbw.eu/stw/descriptor/16815-3) is missing from the output.

Now check the output of the `mllm` project by entering `echo "The History of Salt Prices in Europe" | annif suggest stw-mllm-en`.
When trained as described in the mllm exercise the output should be similar to:

    <http://zbw.eu/stw/descriptor/16815-3>	Europe	0.6158202290534973
    <http://zbw.eu/stw/descriptor/14205-5>	Salt	0.5322813987731934
    <http://zbw.eu/stw/descriptor/10213-5>	Price	0.4636836349964142
    <http://zbw.eu/stw/descriptor/15690-2>	History	0.162480890750885

In this set of suggestions all relevant topics of the title are present.
However, [Europe](http://zbw.eu/stw/descriptor/16815-3) appears before price and subject matter experts may deem the topic more important than the location.
To remedy the mistakes of the individual projects we will combine them in an ensemble.

### 2. Define an ensemble project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

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

If you have created an Omikuji project (see [Omikuji exercise](OPT_omikuji_project.md)), you can include it
as a source as well.

### 3. Check the output of the ensemble project

Entering `echo "The History of Salt Prices in Europe" | annif suggest stw-ensemble-en` should give you results similar to:

<http://zbw.eu/stw/descriptor/14205-5>	Salt	0.6059554815292358
<http://zbw.eu/stw/descriptor/16815-3>	Europe	0.48833876848220825
<http://zbw.eu/stw/descriptor/10213-5>	Price	0.3988715410232544
<http://zbw.eu/stw/descriptor/15690-2>	History	0.1845642626285553
<http://zbw.eu/stw/descriptor/26500-1>	Mongolians	0.09527414292097092
<http://zbw.eu/stw/descriptor/11519-4>	Price level	0.08797984570264816
<http://zbw.eu/stw/descriptor/12794-5>	Pricing strategy	0.08781763911247253
<http://zbw.eu/stw/descriptor/10978-5>	Price regulation	0.08762484788894653
<http://zbw.eu/stw/descriptor/15104-6>	Price statistics	0.08698692172765732
<http://zbw.eu/stw/descriptor/10217-4>	Price theory	0.08618881553411484

While not perfect, the combined output is an improvement.
All relevant parts of the title are present and [Europe](http://zbw.eu/stw/descriptor/16815-3) as well as [Mongolians](http://zbw.eu/stw/descriptor/26500-1) appear further down the list.

### 4. Test the project on an example document

Try asking for subject suggestions from the ensemble project to the same
document that you used in Exercise 2 (TFIDF project).

    annif suggest stw-ensemble-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this ensemble project.

## 5. Evaluate the ensemble project on a collection of documents

You can generate evaluation metrics on the ensemble project by running

    annif eval stw-ensemble-en data-sets/stw-zbw/docs/test/

Evaluation should take around 5-10 minutes. Take note of the F1@5 and NDCG
measures you got and compare them with the previous figures from TFIDF and
MLLM projects. Which one works best?

Congratulations, you've completed Exercise 6 for the `stw-zbw` data set! You have a working ensemble
project and you know how well it works compared to the projects it is based on.

## Extra determining weights of ensemble source

<details>
<summary>Learn how to automatically test different weights for ensemble sources.</summary>

As seen in the main exercise, an ensemble can combine the strengths of different backends and reduce the effects of their shortcomings.
However, you still have to select the weights of the sources constituting an ensemble.
As strength and weaknesses of individual algorithms may have varying effect on distinct documents it is hard to determine the weights manually.

With some time on you hand, Annif can assist you in automatically trying out different weight combinations.
This is done using [Optuna](https://optuna.org/), a software library for hyperparameter optimization.
The problem the library tries to solve is called hyper parameter optimization.
A hyperparamater is considered a parameter that is not learned by the model but set externally.
As the weights of the ensemble source are not learned, it is possible to use software for hyperparameter optimization to find a good set of weights.
Generally speaking hyperparameter optimization initially evaluates a few random parameter combinations and then tries to guess good parameters from these starting points.
For automated subject indexing the evaluation of a parameter combination is done by computing evaluation metrics on a validation set.

If you use the `yso-nlf` data set, hyperparameter optimization can be run with the following command:

    annif hyperopt yso-ensemble-en data-sets/yso-nlf/docs/validate/

If you use the `stw-zbw` data set, hyperparameter optimization can be run with the following command:

    annif hyperopt stw-ensemble-en data-sets/stw-zbw/docs/validate

</details>
---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
