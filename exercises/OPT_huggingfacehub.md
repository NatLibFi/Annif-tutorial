# Optional exercise: Sharing models via Hugging Face Hub 

The [🤗 Hugging Face](https://huggingface.co/) is a company and ecosystem for artificial intelligence applications and their development.
The Hugging Face Hub is a platform similar to GitHub; it hosts git repositories of three types:
- [Datasets](https://huggingface.co/datasets) - for training models
- [Models](https://huggingface.co/models) - the actual AI models
- [Spaces](https://huggingface.co/spaces) - applications using the models 

Annif's CLI includes commands `upload` and `download` to make it easy to share projects and their associated vocabularies 
via Hugging Face Hub model repositories. 

Both upload and download commands expect a glob pattern for project IDs as the first argument (for example `"*"` to match all project IDs) 
and a Hugging Face Hub repository ID as the second agument.

For more information about the commands see this [Wikipage](https://github.com/NatLibFi/Annif/wiki/Hugging-Face-Hub-integration).

## 1. Download NN ensemble project

If you use the `yso-nlf` data set, run this command to download the project from [NatLibFi/Annif-tutorial-YSO](https://huggingface.co/NatLibFi/Annif-tutorial-YSO) HFH repository:

    annif download yso-nn-ensemble-en NatLibFi/Annif-tutorial-YSO

If you use the `stw-zbw` data set, run this command to download the project from [TBD]() HFH repository:

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

## 3. Upload projects
WIP
