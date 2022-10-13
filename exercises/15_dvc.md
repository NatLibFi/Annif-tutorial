# Exercise 15: Data Version Control

In this exercise we will look at how to use [Data Version Control
(DVC)](https://dvc.org/) with Annif. DVC is a command-line tool designed to ease the
version control of machine learning projects. It works on top of [git](https://git-scm.com/).

## Installing DVC

DVC is included in the Virtualbox image of this tutorial; to your computer it
can be installed using `pip` or `pipx` from [PyPI](https://pypi.org/project/dvc/).
See details on [dvc.org](https://dvc.org/doc/install). 

## About DVC with Annif

DVC offers many functionalities for working with machine-learning models.
In case of Annif, maybe the most valuable feature is the possibility to build
[_data pipelines_](https://dvc.org/doc/start/data-management/data-pipelines),
which consist of separate _stages_. The whole pipeline
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

It is best to create a new git repository `Annif-tutorial-dvc` for this:

    pwd    # Check that you start in the Annif-tutorial directory
    cd ..  # And move one level up from there
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

    cd corpora
    dvc import-url ../../Annif-tutorial/data-sets/yso-nlf/yso-skos.ttl skos.ttl
    dvc import-url ../../Annif-tutorial/data-sets/yso-nlf/yso-finna.tsv.gz shorttext-docs.tsv.gz
    dvc import-url ../../Annif-tutorial/data-sets/yso-nlf/docs/ docs

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

A DVC pipeline is defined in an YAML file, by default of the name [`dvc.yaml`](https://dvc.org/doc/user-guide/project-structure/dvcyaml-files).
DVC can intelligently track (hyper)parameter changes in a file, which in case of
Annif is the projects configuration file. However, the INI/CFG format does not
work in this, but the format has to be [TOML](https://en.wikipedia.org/wiki/TOML).

Create a projects configuration file `projects.toml` containing the configurations 
for tfidf, MLLM, and NN ensemble projects.

<details><summary>
Show configurations to use with the <code>nlf-yso</code> data set
</summary>

```toml
[yso-tfidf-en]
name = "YSO TFIDF project"
language = "en"
backend = "tfidf"
vocab = "yso"
analyzer = "snowball(english)"

[yso-mllm-en]
name = "YSO MLLM project"
language = "en"
backend = "mllm"
vocab = "yso"
analyzer = "snowball(english)"

[yso-nn-ensemble-en]
name = "YSO neural ensemble project"
language = "en"
backend = "nn_ensemble"
vocab = "yso"
sources = "yso-tfidf-en,yso-mllm-en:2"
nodes = "100"
dropout_rate = "0.2"
epochs = "4"
```
</details>

<details><summary>
Show configurations to use with the <code>stw-zbw</code> data set
</summary>

```toml
[stw-tfidf-en]
name = "STW TFIDF project"
language = "en"
backend = "tfidf"
vocab = "stw"
analyzer = "snowball(english)"

[stw-mllm-en]
name = "STW MLLM project"
language = "en"
backend = "mllm"
vocab = "stw"
analyzer = "snowball(english)"

[stw-nn-ensemble-en]
name = "STW neural ensemble project"
language = "en"
backend = "nn_ensemble"
vocab = "stw"
sources = "stw-tfidf-en,stw-mllm-en:2"
nodes = "100"
dropout_rate = "0.2"
epochs = "4"
```
</details>


Create `dvc.yaml` with the following contents, and **uncomment the line defining the vocab variable depending on the data-set you use**:
```yaml
vars:
  #- vocab: 'stw'  # Uncomment this if you are using the STW dataset
  #- vocab: 'yso'  # Uncomment this if you are using the YSO dataset
  - docs: 100      # Max. number of documents to use

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
    params:
    - projects.toml:
      - ${vocab}-tfidf-en
    outs:
    - data/projects/${vocab}-tfidf-en
  # Train MLLM project
  train-mllm:
    cmd: annif train ${vocab}-mllm-en corpora/docs/train -d ${docs}
    deps:
    - corpora/docs/train
    - data/vocabs/${vocab}
    params:
    - projects.toml:
      - ${vocab}-mllm-en
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
    params:
    - projects.toml:
      - ${vocab}-nn-ensemble-en
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
      params:
      - projects.toml:
        - ${item}
      metrics:
      - reports/${item}.json:
          cache: false
```

Now the pipeline is set up, and can be executed with one command:

    dvc repro

Running the pipeline as such takes only 5-10 min, because the `docs` variable limits the number of documents used in stages to 100.
When the `docs` is increased e.g. to 10000000 to cover all available (short-text) documents, reproducing the pipeline takes 30-50 min.

When finished, the evalution reports can be
shown using DVC:

    dvc metrics show

Finally commit the changes with `git`:

    git add reports/
    git commit -am "set up, train & evaluate projects"

Congratulations, you've completed Exercise 15, you have a working DVC pipeline
allowing easy and reproducible way to train and evaluate Annif projects!

---

<p align="center">
<a href="/exercises/14_custom_corpus.md">« Previous</a> |
</p>
