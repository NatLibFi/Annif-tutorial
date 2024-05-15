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
and a Hugging Face Hub repository ID as the second argument (user or organisation name and repository name separated by a slash:`user_or_org/repo`).

## 1. Download NN ensemble project

If you use the `yso-nlf` data set, run this command to download the project from [NatLibFi/Annif-tutorial](https://huggingface.co/NatLibFi/Annif-tutorial) repository:

    annif download yso-nn-ensemble-en NatLibFi/Annif-tutorial

If you use the `stw-zbw` data set, run this command to download the project from [TBD]() repository:

    TBD

## 2. Test the downloaded project

The project and vocabulary data files have been downloaded and placed to `data/` directory and they are ready to be used, but the downloaded project configuration file has been placed in the `projects.d/` directory.
To access the project, you need use the `--projects` option to make Annif to look for the project configuration files from the right place:

    annif list-projects -p projects.d/

You should see the project you downloaded in the listing.

_WIP The NN ensemble project uses also the base projects, i.e. TFIDF and MLLM projects, so it it necessary to put all the cofigurations in the same place._

Now you can test the NN ensemble project for suggestions.

If you use the `yso-nlf` data set, run this command:

    echo "Hugging Face, Inc. develops computation tools for building applications using machine learning." | annif suggest yso-nn-ensemble-en -p projects.d/

If you use the `stw-zbw` data set, run this command:

    TBD

## EXTRA: Upload projects
<details><summary>
See details of extra section
</summary>
    
For uploading projects you need to have an account on Hugging Face Hub; you can create one [here](https://huggingface.co/join).
You also need to be logged in to HFH, and the repository to upload to needs to exist.

### Create a new Model repository 
You can use [this link](https://huggingface.co/new) or navigate to it via your HFH profile from the round profile image in the upper right corner on the HFH website.
Give the repository the name `Annif-tutorial`; it can be private or public.

### Login to Hugging Face Hub
Create a User Access token to your HFH account in [this page](https://huggingface.co/settings/tokens) with write access.

Use command

    huggingface-cli login

and pass your token when asked for it.
Answer `n` to when asked `Add token as git credential?`.

Alternatively to running `huggingface-cli login` you can pass your User Access token with the `--token` option of the `annif upload` command.

### Upload a project
Upload your TFIDF project.

If you use the `yso-nlf` data set, run this command:

    annif upload yso-tfidf-en <your-username>/Annif-tutorial  # --token <your-token>

If you use the `stw-zbw` data set, run this command:

    annif upload stw-tfidf-en <your-username>/Annif-tutorial  # --token <your-token>


</details>

---

Congratulations, you've completed exercise on Hugging Face Hub integration! 


## More information

For more information, see the documentation in the Annif wiki:

* [Hugging Face Hub integration](https://github.com/NatLibFi/Annif/wiki/Hugging-Face-Hub-integration)
