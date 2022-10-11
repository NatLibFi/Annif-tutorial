# Exercise 15: Data Version Control

In this exercise we will look at how to use [Data Version Control
(DVC)](https://dvc.org/) with Annif. DVC is a command-line tool designed to ease the
version control of machine learning projects. It works on top of [git](https://git-scm.com/).

## Installing DVC

DVC is included in the Virtualbox image of this tutorial; to your computer it
can be installed using `pip` or `pipx` from PyPI. See details on
[dvc.org](https://dvc.org/doc/install). 

## About DVC with Annif

DVC offers many functionalities that ease working with machine-learning models.
In case of Annif, maybe the most valuable feature is the possibility to build
_data pipelines_, which consist of separate _stages_. The whole pipeline
can be conviniently operated on with `dvc` commands.

For example, the stages of a pipeline can be

1. load the vocabulary,
2. train the model,
3. evaluate the model.

This organization of steps could be easily achived also with a plain bash
script. The benefit of using DVC for this is that DVC can track the inputs and
outputs of each stage and cache the stages. This eases working on the pipeline:
on reruns of the pipeline, if there are no changes in the inputs of a stage,
that stage is skipped and its output is taken from the cache. 

The DVC tracking works together with git, and this allows efficient version
control of large data-sets. DVC also eases tuning models with [experiment
management](https://dvc.org/doc/user-guide/experiment-management).

## DVC repository for Annif models

In this exercise a DVC pipeline is set up for some of the projects seen in the
previous exercises.

It is best to create a new git repository for this:

    cd  # Change directory to home directory
    git init Annif-tutorial-dvc
    cd Annif-tutorial-dvc/

Run these commands to create a DVC data directory (`.dvc`) and ignore file
(`.dvcignore`) and commit them:

    dvc init
    git commit -m "initialize DVC"

Enable DVC autostage, which avoids the need to run `git add` commands:

    dvc config core.autostage true
    git commit .dvc/config -m "enable DVC autostage"

Create directories for the metric reports and training data to be used in the
pipeline:

    mkdir corpora reports

Import the vocabulary, short-text and full-text documents.
If you use the `yso-nlf` data set, run these commands:

    # TODO

If you use the `stw-zbw` data set, run these commands:

    cd corpora
    dvc import-url ../../Annif-tutorial/data-sets/stw-zbw/stw-skos.ttl skos.ttl
    dvc import-url ../../Annif-tutorial/data-sets/stw-zbw/stw-econbiz.tsv.gz shorttext-docs.tsv.gz
    dvc import-url ../../Annif-tutorial/data-sets/stw-zbw/docs/ docs

See what's happened:

    dvc status

Unfreeze the
["frozen"](https://dvc.org/doc/command-reference/unfreeze#description) `.dvc`
files:

    dvc unfreeze docs.dvc shorttext-docs.tsv.gz.dvc skos.ttl.dvc 

Commit changes:

    cd ..
    git commit -am "import corpora"

## Pipeline for Annif projects

A DVC pipeline is defined in an YAML file, by default of the name `dvc.yaml`.
Copy the project configuration file containing the configurations made in
previous exercises (or create a new `projects.cfg` with tfidf, MLLM, and NN ensemble
configurations):

    cp ../Annif-tutorial/projects.cfg .

Create `dvc.yaml` with the following contents, and **uncomment the line defining the vocab variable depending on the data-set you use**:
```yaml
vars:
  #- vocab: 'stw'  # Uncomment this if you are using the STW dataset
  #- vocab: 'yso'  # Uncomment this if you are using the YSO dataset
  - docs: 100      # How many documents to use in training stages

stages:
  # Load vocabulary
  load-vocab:
    cmd: annif load-vocab ${vocab} corpora/skos.ttl --force
    deps:
    - corpora/skos.ttl
    outs:
    - data/vocabs/${vocab}
  # Train tfidf project
  train-tfidf:
    cmd: annif train ${vocab}-tfidf-en corpora/shorttext-docs.tsv.gz -d ${docs}
    deps:
    - corpora/shorttext-docs.tsv.gz
    - data/vocabs/${vocab}
    outs:
    - data/projects/${vocab}-tfidf-en
  # Train MLLM project
  train-mllm:
    cmd: annif train ${vocab}-mllm-en corpora/docs/train -d ${docs}
    deps:
    - corpora/docs/train
    - data/vocabs/${vocab}
    outs:
    - data/projects/${vocab}-mllm-en
  # Train nn-ensemble project
  train-nn-ensemble:
    cmd: annif train ${vocab}-nn-ensemble-en corpora/docs/train -d ${docs}
    deps:
    - corpora/docs/train
    - data/vocabs/${vocab}
    - data/projects/${vocab}-mllm-en
    - data/projects/${vocab}-tfidf-en
    outs:
    - data/projects/${vocab}-nn-ensemble-en
  # Evaluate projects in a loop
  eval-en:
    foreach:
      - ${vocab}-mllm-en
      - ${vocab}-tfidf-en
      - ${vocab}-nn-ensemble-en
    do:
      cmd:
      - annif eval ${item} -m F1@5 -m NDCG --metrics-file reports/${item}.json corpora/docs/test/ -d ${docs}
      deps:
      - corpora/docs/test
      - data/projects/${item}
      metrics:
      - reports/${item}.json:
          cache: false
```

Now the pipeline is set up, and can be executed with one command:

    dvc repro

Running the pipeline as such takes about 3 min, because the `docs` variable limits the number of documents used in training stages to 100.
When the `docs` is increased e.g. to 10000000 to cover all available (short-text) documents, reproducing the pipeline takes about XX min.

When finished, the evalution reports can be
shown using DVC:

    dvc metrics show

Finally commit the changes with `git`:

    git add reports/
    git commit -a -m "set up, train & evaluate projects"

Congratulations, you've completed Exercise 15, you have a working DVC pipeline
allowing easy and reproducible way to train and evaluate Annif projects!

---

<p align="center">
<a href="/exercises/14_custom_corpus.md">« Previous</a> |
</p>
