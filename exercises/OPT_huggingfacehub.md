# Optional exercise: Sharing models via Hugging Face Hub 

The [🤗 Hugging Face](https://huggingface.co/) is a company and ecosystem for artificial intelligence applications and their development.
The Hugging Face Hub is a platform similar to GitHub; it hosts git repositories of three types:
- [Datasets](https://huggingface.co/datasets) - for training models
- [Models](https://huggingface.co/models) - ready-to-use models
- [Spaces](https://huggingface.co/spaces) - applications using the models 

Annif's CLI includes commands [`upload`](https://annif.readthedocs.io/en/stable/source/commands.html#annif-upload) 
and [`download`](https://annif.readthedocs.io/en/stable/source/commands.html#annif-download) to make it easy to share projects and their associated vocabularies
via Hugging Face Hub model repositories.

Both upload and download commands expect a glob pattern for project IDs as the first argument (for example `"*"` to match all project IDs)
and a Hugging Face Hub repository ID as the second argument (user or organisation name and repository name separated by a slash: `user_or_org/repo`).

## 1. Download Hogwarts project

In the optional [Hogwarts exercise](/exercises/OPT_hogwarts.md) the aim is to train a project using fastText algorithm to implement a Sorting Hat.
Whether you have already completed that exercise or not, you can run perform this exercise; existing projects will not be overwritten.

Run this command to download the project from the Hugging Face Hub repository [NatLibFi/Annif-tutorial](https://huggingface.co/NatLibFi/Annif-tutorial) :

    annif download hogwarts NatLibFi/Annif-tutorial --trust-repo  # the option is needed only for the first download 

Note that the repository contains all YSO, 20news, and Hogwarts projects trained in this tutorial (see the ["Files and versions" tab](https://huggingface.co/NatLibFi/Annif-tutorial/tree/main)), and you can download any of them.

> [!CAUTION]
> The `annif download` command has a `--trust-repo` option, which needs to be used if the repository to download from has not been used previously (that is if the repository does not appear in the local Hugging Face Hub cache).
> This option is to remind of the risks of using models from the internet; _the project downloads should only be done from trusted sources_.
> For more information of the risks see the [Hugging Face Hub documentation](https://huggingface.co/docs/hub/en/security-pickle).

## 2. Test the downloaded project

The project and vocabulary data files have been downloaded and placed to `data/` directory and they are ready to be used, but the downloaded project configuration file has been placed in the `projects.d/` directory.
To access the project, you need use the `--projects` option to make Annif to look for the project configuration files from the right place:

    annif list-projects -p projects.d/

Alternatively you could append the configuration from `projects.d/hogwarts.cfg` to `projects.cfg` with the command `cat projects.d/hogwarts.cfg >> projects.cfg`, after which the `-p projects.d/` option is not needed.

You should see the project you downloaded in the listing, and now you can use the `hogwarts` project for suggestions. 
For example, run this command:

    echo "Hugging Face" | annif suggest hogwarts -p projects.d/

## EXTRA: Upload projects
<details><summary>
See details of extra section
</summary>

### Create a new model repository 
For uploading projects you need to have an account on the Hugging Face Hub; you can create one [here](https://huggingface.co/join).
You also need to be logged in to service, and the repository to upload to needs to exist.

To create a new model repository you can use [this link](https://huggingface.co/new) 
or navigate to it via your Hugging Face Hub profile (the round profile image in the upper right corner on the HFH website).
Give the repository the name `Annif-tutorial`; the repository can be either private or public.

### Login to Hugging Face Hub
Create a User Access token to your HFH account in [this page](https://huggingface.co/settings/tokens) with write access.

Use command

    huggingface-cli login

and pass your token when asked for it.
Decline by answering `n` to when asked `Add token as git credential?`.

Alternatively to running `huggingface-cli login` you can pass your User Access token with the `--token` option of the `annif upload` command.

### Upload a project
Upload your TFIDF project, which is small in size and so the upload is fast.

If you use the `yso-nlf` data set, run this command:

    annif upload yso-tfidf-en <your-username>/Annif-tutorial  # --token <your-token>

If you use the `stw-zbw` data set, run this command:

    annif upload stw-tfidf-en <your-username>/Annif-tutorial  # --token <your-token>

To upload all your projects, you could use a glob pattern `"*"` in place of the full project ID
(here the quotation marks around the pattern are necessary to avoid the shell to expand the `*` wildcard to all filenames in your current directory), 
but note that size of the projects can be several gigabytes.

A subset of all projects can be uploaded by entering the common parts of the project IDs and a wildcard, 
e.g. the 20news projects of the [classification exercise](exercises/OPT_classification.md) with

    annif upload 20news-* <your-username>/Annif-tutorial

### Automatic creation and update of Model Card
HFH model repositories have `README.md` files, called [Model Cards](https://huggingface.co/docs/hub/model-cards), that can contain human readable description of the model and some metadata in YAML format.

For example, the [NatLibFi/Annif-tutorial](https://huggingface.co/NatLibFi/Annif-tutorial) repository includes a short textual description including a list of the projects contained in the repository and metadata in YAML format.
The metadata is shown on the website under the repository name: the intended task of the model, the dataset used to train the model, the language the model is intended for, some freeform tags and the licence of the model:

![image](https://github.com/NatLibFi/Annif-tutorial/assets/34240031/32d5d497-8141-4afd-8ada-dac51473d625)

By default, when running `annif upload` Annif automatically creates or updates some information of the Model Card.
This behaviour can be turn offf with the `--no-modelcard` option.

</details>

---

Congratulations, you've completed exercise on Hugging Face Hub integration! 


## More information

For more information, see the documentation in the Annif wiki:

* [Hugging Face Hub integration](https://github.com/NatLibFi/Annif/wiki/Hugging-Face-Hub-integration)

---

<p align="center">
|
<a href="/README.md">Back to the main page »</a>
</p>
