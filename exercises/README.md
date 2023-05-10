# Annif tutorial outline
This page is an overview of Annif tutorial contents. There are video-only lectures that are prefixed with :film_strip:.
Exercises marked with :computer: require some coding, and those with :book: are for reading only.

## :film_strip: Introduction and overview

[![Video](/img/intro-slides-1.png)](https://youtu.be/d9_OUUZhjTM)

- [slides](/presentations/intro-slides.pdf)
- [transcript of video](/transcripts/intro.md)
- [introduction to the Linux command line](/exercises/linux_command_line.md)

The exercises drawn with thick borders and a blue background are **core**, the
others are optional extras.

```mermaid
%%{
    init: {
       "flowchart": {
           "nodeSpacing": 20,
           "rankSpacing": 45,
           "useMaxWidth": true,
           "curve": "linear"
        }
    }
}%%
flowchart TD
    classDef core fill:#ADD8E6,stroke:#000000,stroke-width:2px;
    classDef optional fill:#ffffff,stroke:#000000,stroke-width:1px;

    install([install]) --> tfidf([TFIDF])
    tfidf --> webui([Web UI])
    webui --> eval([evaluate])
    eval --> mllm([MLLM])
    mllm --> ensemble([ensemble])
    ensemble --> nn_ensemble([NN ensemble])
    ensemble --> custom([Custom corpus])
    ensemble --> dvc([DVC])
    mllm --> ft([Hogwarts/fastText])
    mllm --> lang_filter([Languages & filtering])
    webui --> rest([REST API])
    rest --> production([Production use])
    eval --> omikuji([Omikuji])
    omikuji --> classification([Classification])
    class install core
    class tfidf core
    class webui core
    class eval core
    class mllm core
    class lang_filter optional
    class ensemble core
    class dvc optional
    class rest optional
    class production optional
    class omikuji optional
    class classification optional
    class ft optional
    class custom optional
    class nn_ensemble optional
```

## :computer: 1. Installation

Select your installation type. If you don’t know what to choose, we suggest using VirtualBox.
- [exercise](/exercises/01_install_annif.md)

### 1.1. VirtualBox install

[![Video](/img/annif-install-virtualbox-slides-1.png)](https://youtu.be/z_Fq-87QbyQ)

- [slides](/presentations/annif-install-virtualbox-slides.pdf)
- [transcript of video](/transcripts/annif-install-virtualbox.md)
- [VirtualBox image download (~2GB)](https://annif.org/download/)

### 1.2. Docker install

[![Video](/img/annif-install-docker-slides-1.png)](https://youtu.be/j_VeC_NeVcw)

- [slides](/presentations/annif-install-docker-slides.pdf)
- [transcript of video](/transcripts/annif-install-docker.md)

### 1.3. Linux native install

[![Video](/img/annif-install-linux-slides-1.png)](https://youtu.be/I7oApwl-NFk)

- [slides](/presentations/annif-install-linux-slides.pdf)
- [transcript of video](/transcripts/annif-install-linux.md)
- [Annif README file with installation instructions](https://github.com/NatLibFi/Annif/blob/master/README.md)

## :film_strip: Data sets
This tutorial provides two example data sets; one of them should be chosen to be used in the exercises.

[![Video](/img/data-sets-slides-1.png)](https://youtu.be/S4E3d3o5HWg)

- [slides](/presentations/data-sets-slides.pdf)
- [transcript of video](/transcripts/data-sets.md)

## :computer: 2. TFIDF project
The basic functionality of Annif is introduced by setting up and training a project using a TFIDF model.

[![Video](/img/tfidf-project-slides-1.png)](https://youtu.be/Hwl6PUoG_hc)

- [slides](/presentations/tfidf-project-slides.pdf)
- [transcript of video](/transcripts/tfidf-project.md)
- [exercise](/exercises/02_tfidf_project.md)

## :film_strip: Algorithms
The principles of the algorithm types used by Annif models are presented.

[![Video](/img/algorithms-slides-1.png)](https://youtu.be/OvPx8Ipe3BU)

- [slides](/presentations/algorithms-slides.pdf)
- [transcript of video](/transcripts/algorithms.md)

#### :book: [Optional]
Slides on associative algorithms for XMTC (by CSC's [@jmakoske](https://github.com/jmakoske) & [@mvsjober](https://github.com/mvsjober)):
- [Extreme multi-label text classification (XMTC)](/presentations/optional-slides/HPD-XMTC-2020-11-13.pdf)
- [Tree-based methods for XMTC](/presentations/optional-slides/HPD-TBM-2020-11-13.pdf)
- [Neural networks for XMTC](/presentations/optional-slides/HPD-NN-2020-11-13.pdf)


## :computer: 3. Web UI
The web user interface of Annif allows quick testing of projects.

[![Video](/img/web-ui-slides-1.png)](https://youtu.be/wkDbVnkuV6E)

- [slides](/presentations/web-ui-slides.pdf)
- [transcript of video](/transcripts/web-ui.md)
- [exercise](/exercises/03_web_ui.md)

## :computer: [Optional] REST API
The REST API of Annif can be used for integrating Annif with other systems.
- [exercise](/exercises/OPT_rest_api.md)

## :book: [Optional] Production use
Here is described aspects to consider when going from testing and development phase to a production-ready deployment of Annif.
- [exercise](/exercises/OPT_production_use.md)

## :computer: Metrics & evaluation
Quantitative testing and comparison of projects against standard metrics can be done using the `eval` command.

[![Video](/img/metrics-and-evaluation-slides-1.png)](https://youtu.be/zWMXUfLJtn0)

- [slides](/presentations/metrics-and-evaluation-slides.pdf)
- [transcript of video](/transcripts/metrics-and-evaluation.md)
- [exercise](/exercises/04_evaluate.md)

## :computer: [Optional] Omikuji project
Omikuji is a tree-based associative machine learning model that often produces very good results, but requires more resources than the TFIDF model.
This exercise is optional, because training an Omikuji model on the full datasets can take around 40 minutes.
- [exercise](/exercises/OPT_omikuji_project.md)

## :computer: 5. MLLM project
MLLM is a lexical algorithm for matching terms in document text to terms in a controlled vocabulary.
 

[![Video](/img/mllm-slides-1.png)](https://youtu.be/4cblDQ_HA3w)

- [slides](/presentations/mllm-slides.pdf)
- [transcript of video](/transcripts/mllm.md)
- [exercise](/exercises/05_mllm_project.md)

## :computer: [Optional] Hogwarts Sorting Hat using fastText
Yet another algorithm you can try is fastText, which can also work on the level of individual characters.
- [exercise](/exercises/OPT_hogwarts.md)

## :book: [Optional] Languages and filtering
The ability of Annif to process text in a given language depends on the choice of the analyzer, which performs text preprocessing.
Sometimes it might be useful to filter out parts of the document that are not in the main language of the document.
- [exercise](/exercises/OPT_langfilter.md)

## :computer: 6. Ensemble project
An ensemble project combines results from the projects set up in previous exercises.

[![Video](/img/ensemble-project-slides-1.png)](https://youtu.be/0hwB3PwAcUM)

- [slides](/presentations/ensemble-project-slides.pdf)
- [transcript of video](/transcripts/ensemble-project.md)
- [exercise](/exercises/06_ensemble_project.md)

## :computer: [Optional] Neural network ensemble project
A neural network ensemble can be trained to intelligently combine the results from the base projects.

- [exercise](/exercises/OPT_nn_ensemble_project.md)

## :computer: [Optional] Automated classification
Annif can also be used for multiclass classification, where the goal is to choose the correct class among mutually exclusive classes. This exercise demonstrates automated classification using the well known "Twenty Newsgroups" data set.

- [exercise](/exercises/OPT_classification.md)

## :computer: [Optional] Custom corpus
A big challenge in applying Annif to own data is gathering documents and converting them to form a corpus in suitable format. In this exercise metadata from arXiv articles are used to form a corpus, which can be used to train Annif models.

- [exercise](/exercises/OPT_custom_corpus.md)
- [Jupyter Notebook](/data-sets/arxiv/create-arxiv-corpus.ipynb)

## :computer: [Optional] Data Version Control

Data Version Control (DVC) eases maintaining machine learning projects. In this exercise a DVC pipeline is used to set up, train and evaluate Annif projects.

- [exercise](/exercises/OPT_dvc.md)

## :film_strip: Closing
Summary of the material in the tutorial and some pointers to further information.

[![Video](/img/closing-slides-1.png)](https://youtu.be/LEl1fAkLUzA)

- [slides](/presentations/closing-slides.pdf)
- [transcript of video](/transcripts/closing.md)
- [feedback](https://forms.gle/mBkk8eAufXUmbQ716)
