# Optional exercise: Sharing models via Hugging Face Hub 

The 🤗 Hugging Face Hub intends to facilitate the hosting and sharing of AI models and datasets as well as demo applications.

Annif's CLI includes commmands `upload` and `download` to make it easy to share projects and their associated vocabularies 
via Hugging Face Hub model repositories. 

Both upload and download commands expect a glob pattern for projects ID as the first argument 
and a Hugging Face Hub repository ID as the second agument.

## 1. Download projects
Run this command to download the projects for English from NatLibFi/FintoAI-data-YKL repository:

    annif download "*-en" NatLibFi/FintoAI-data-YKL

This places the projects and vocabulary data files to `data/` directory and the project configurations as separate `.cfg` files in `projects.d/` directory.

## 2. Test the downloaded projects

You need use the `--projects` option to make Annif to look for the project configuration files from the right place:

    annif list-projects -p projects.d/

You should see three entries.

Then you can test the projects, run for example this command:

    echo "Hugging Face, Inc. develops computation tools for building applications using machine learning." | annif suggest ykl-en -p projects.d/

## 3. Upload projects
WIP

For more information see this [Wikipage](https://github.com/NatLibFi/Annif/wiki/Hugging-Face-Hub-integration).
