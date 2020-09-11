# Annif tutorial outline

## 1. Introduction and overview

[![Watch the video](img/ZKN22mXKMm8.jpg)](https://youtu.be/ZKN22mXKMm8)

- [slides]()
- [transcript of video]()

## 2. Installation
Select your installation type. If you don’t know what to choose, we suggest using VirtualBox.
- [exercise](/exercises/01_install_annif.md)

### 2.1. VirtualBox install

- [slides]()
- [transcript of video]()
- [VirtualBox image download (~2GB)](https://annif.org/download/)

### 2.2. Docker install

- [slides]()
- [transcript of video]()

### 2.3. Linux native install

- [slides]()
- [transcript of video]()
- [Annif README file with installation instructions](https://github.com/NatLibFi/Annif/blob/master/README.md)

## 3. Data sets
This tutorial provides two data sets; one of them should be chosen to be used in the exercises.

- [slides]()
- [transcript of video]()

## 4. TFIDF project
The basic functionality of Annif is introduced by setting up and training a project using a TFIDF model.

- [slides]()
- [transcript of video]()
- [exercise](/exercises/02_tfidf_project.md)

## 5. Algorithms
The principles of the algorithm types used by Annif models are presented.

- [slides]()
- [transcript of video]()

## 6. Web UI
The web user interface of Annif allows quick testing of projects.

- [slides]()
- [transcript of video]()
- [exercise](/exercises/03_web_ui.md)

**[Optional] REST API**

In the background the web UI uses the API of Annif, which can be accessed also directly.
- [exercise](/exercises/07_rest_api.md)


## 7. Metrics & evaluation
More quantitative testing and comparison of projects can be done based on metrics given by Annif's evaluation command.

- [slides]()
- [transcript of video]()
- [exercise](/exercises/04_evaluate.md)

**[Optional] Omikuji project**

The evaluation results of the TFIDF project can be compared for example to an Omikuji based project.
- [exercise](/exercises/08_omikuji_project.md)

## 8. Installing Maui Server
### 8.1. Docker

- [slides]()
- [transcript of video]()

### 8.2.Linux local install

- [slides]()
- [transcript of video]()

## 9. Maui project
Maui is a lexical algorithm for matching terms in document text to terms in a controlled vocabulary.

- [slides]()
- [transcript of video]()
- [exercise](/exercises/05_maui_project.md)

**[Optional] Hogwarts Sorting Hat using fastText**

Yet another algorithm you can try is fastText, which can dig into the character level of a text.
- [exercise](/exercises/09_hogwarts.md)

## 10. Ensemble project
An ensemble project combines results from the projects set up in previous exercises.

- [slides]()
- [transcript of video]()
- [exercise](/exercises/06_ensemble_project.md)

**[Optional] Neural network ensemble project and incremental learning**

Neural network ensemble can be trained to intelligently combine the results from the base projects. NN ensemble is also capable to online incremental learning, i.e. the training can be continued while the model is in use.

- [exercise](/exercises/10_nn_ensemble_project.md)
- [exercise](/exercises/11_incremental_learning.md)

## 11. Closing

- [slides]()
- [transcript of video]()
