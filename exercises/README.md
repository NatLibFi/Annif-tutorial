# Annif tutorial outline

## 1. Introduction and overview

[![Video](/img/intro-slides-1.png)](https://www.youtube.com/watch?v=h8s3dDYYNP4&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=1)

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

## 2. Installation

Select your installation type. If you don’t know what to choose, we suggest using VirtualBox.
- [exercise](/exercises/01_install_annif.md)

### 2.1. VirtualBox install

[![Video](/img/annif-install-virtualbox-slides-1.png)](https://www.youtube.com/watch?v=z_Fq-87QbyQ&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=2)

- [slides](/presentations/annif-install-virtualbox-slides.pdf)
- [transcript of video](/transcripts/annif-install-virtualbox.md)
- [VirtualBox image download (~2GB)](https://annif.org/download/)

### 2.2. Docker install

[![Video](/img/annif-install-docker-slides-1.png)](https://www.youtube.com/watch?v=j_VeC_NeVcw&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=3)

- [slides](/presentations/annif-install-docker-slides.pdf)
- [transcript of video](/transcripts/annif-install-docker.md)

### 2.3. Linux native install

[![Video](/img/annif-install-linux-slides-1.png)](https://www.youtube.com/watch?v=5a7CJ7JF_Qk&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=4)

- [slides](/presentations/annif-install-linux-slides.pdf)
- [transcript of video](/transcripts/annif-install-linux.md)
- [Annif README file with installation instructions](https://github.com/NatLibFi/Annif/blob/master/README.md)

## 3. Data sets
This tutorial provides two example data sets; one of them should be chosen to be used in the exercises.

[![Video](/img/data-sets-slides-1.png)](https://www.youtube.com/watch?v=S4E3d3o5HWg&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=5)

- [slides](/presentations/data-sets-slides.pdf)
- [transcript of video](/transcripts/data-sets.md)

## 4. TFIDF project
The basic functionality of Annif is introduced by setting up and training a project using a TFIDF model.

[![Video](/img/tfidf-project-slides-1.png)](https://www.youtube.com/watch?v=FOdB3tJNSRM&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=6)

- [slides](/presentations/tfidf-project-slides.pdf)
- [transcript of video](/transcripts/tfidf-project.md)
- [exercise](/exercises/02_tfidf_project.md)

## 5. Algorithms
The principles of the algorithm types used by Annif models are presented.

[![Video](/img/algorithms-slides-1.png)](https://www.youtube.com/watch?v=OvPx8Ipe3BU&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=7)

- [slides](/presentations/algorithms-slides.pdf)
- [transcript of video](/transcripts/algorithms.md)

#### [Optional]
Slides on associative algorithms for XMTC (by CSC's [@jmakoske](https://github.com/jmakoske) & [@mvsjober](https://github.com/mvsjober)):
- [Extreme multi-label text classification (XMTC)](/exercises/HPD-XMTC-2020-11-13.pdf)
- [Tree-based methods for XMTC](/exercises/HPD-TBM-2020-11-13.pdf)
- [Neural networks for XMTC](/exercises/HPD-NN-2020-11-13.pdf)


## 6. Web UI
The web user interface of Annif allows quick testing of projects.

[![Video](/img/web-ui-slides-1.png)](https://www.youtube.com/watch?v=wkDbVnkuV6E&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=8)

- [slides](/presentations/web-ui-slides.pdf)
- [transcript of video](/transcripts/web-ui.md)
- [exercise](/exercises/03_web_ui.md)

## 7. [Optional] REST API
The REST API of Annif can be used for integrating Annif with other systems.
- [exercise](/exercises/07_rest_api.md)


## 8. Metrics & evaluation
Quantitative testing and comparison of projects against standard metrics can be done using the `eval` command.

[![Video](/img/metrics-and-evaluation-slides-1.png)](https://www.youtube.com/watch?v=zWMXUfLJtn0&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=9)

- [slides](/presentations/metrics-and-evaluation-slides.pdf)
- [transcript of video](/transcripts/metrics-and-evaluation.md)
- [exercise](/exercises/04_evaluate.md)

## 9. [Optional] Omikuji project
Omikuji is a tree-based associative machine learning model that often produces very good results, but requires more resources than the TFIDF model.
This exercise is optional, because training an Omikuji model on the full datasets can take around 40 minutes.
- [exercise](/exercises/08_omikuji_project.md)

## 10. MLLM project
MLLM is a lexical algorithm for matching terms in document text to terms in a controlled vocabulary.
 

[![Video](/img/mllm-slides-1.png)](https://www.youtube.com/watch?v=kNCW2XF7_ek&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=10)

- [slides](/presentations/mllm-slides.pdf)
- [transcript of video](/transcripts/mllm.md)
- [exercise](/exercises/05_mllm_project.md)

## 11. [Optional] Hogwarts Sorting Hat using fastText
Yet another algorithm you can try is fastText, which can also work on the level of individual characters.
- [exercise](/exercises/09_hogwarts.md)

## 12. Ensemble project
An ensemble project combines results from the projects set up in previous exercises.

[![Video](/img/ensemble-project-slides-1.png)](https://www.youtube.com/watch?v=B-YYJqHiJ3k&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=11)

- [slides](/presentations/ensemble-project-slides.pdf)
- [transcript of video](/transcripts/ensemble-project.md)
- [exercise](/exercises/06_ensemble_project.md)

## 13. [Optional] Neural network ensemble project
A neural network ensemble can be trained to intelligently combine the results from the base projects.

- [exercise](/exercises/10_nn_ensemble_project.md)

## 14. [Optional] Custom corpus
A big challenge in applying Annif to own data is gathering documents and converting them to form a corpus in suitable format. In this exercise metadata from arXiv articles are used to form a corpus, which can be used to train Annif models.

- [exercise](/exercises/12_custom_corpus.md)
- [Jupyter Notebook](/data-sets/arxiv/create-arxiv-corpus.ipynb)

## 15. Closing
Summary of the material in the tutorial and some pointers to further information.

[![Video](/img/closing-slides-1.png)](https://www.youtube.com/watch?v=OrScuYCyHGs&list=PLa9kvrI3VLf5K-bjvVDaIWMi5CACGjPUM&index=12)

- [slides](/presentations/closing-slides.pdf)
- [transcript of video](/transcripts/closing.md)
- [feedback (2021)](https://forms.gle/CtXLHMiEQoBBVRu6A)
