Welcome to this Annif tutorial video. In this video we will install Annif on a Linux system. 

This kind of native Linux installation is best suited to people who have some experience using Linux. It also helps if you’re familiar with installing Python packages.
This video follows the installation steps that are also explained in the Annif top level README file in GitHub and further instructions in the Annif wiki.

Annif requires that you have a recent version of Python 3 installed. You need to check that your Python environment is compatible with the current Annif requirements.

To demonstrate the installation process, I’m using a fresh Xubuntu 20.04 virtual machine that I just created using VirtualBox. However, you can use any other general purpose Linux distribution. If you’re not using Ubuntu or Debian, the commands for installing system packages might be slightly different.


I have already opened a browser window and I'm currently looking at the Annif project on GitHub. Let's check the install instructions here in the README file. The current requirement is at least Python 3.8.

I’m opening a terminal window because the installation needs to be done on the command line.

We can check the Python version we have using the command 

python3 -V

It looks like we have Python 3.8 so all is well.

Now we need to create a virtual Python environment where we install Annif. This is like a sandbox where we can install Python libraries without affecting the rest of the system. However, at least in Ubuntu, we first need to install the support for virtual environments from a system package. We need to do this with root permissions, so we will use sudo.

sudo apt install python3-venv

To create the virtual environment, enter the command:

python3 -m venv annif-venv

Then we need to activate the virtual environment, which means we will tell Python to use libraries from there. We will activate it using the command

source annif-venv/bin/activate

Now the environment is activated. We can see that the shell prompt changed to reflect this. Every time we want to use Annif, we need to activate it in the same way.

Before we install Annif, let’s make sure that we’re using the most recent version of pip, the tool that’s used to install Python packages. We will also install the wheel utility, as it allows installing prebuilt packages called Python wheels, which will save us some time and avoid compiling packages locally.

pip install -U pip wheel


Now we can install Annif itself into the virtual environment:

pip install annif

There’s another thing to take care of. Annif uses the Natural Language Toolkit NLTK for text processing, and NLTK needs to download a model file for punctuation rules before you can use it. We can download the model like this:

python -m nltk.downloader punkt

Now we can check that Annif works:

annif

And we get a usage message that lists all the supported commands. We now have a working installation of Annif with the basic set of features. 

However, in the Annif tutorial exercises we will also use some optional features that need to be installed separately. For clarity we will install the optional dependencies one by one. Let’s start with Omikuji:

pip install annif[omikuji]

Then fastText:

pip install annif[fasttext]

Finally the neural network ensemble:

pip install annif[nn]

Let’s check once more that Annif starts up:

annif

Now we are finished installing Annif on Linux. Thank you for watching!
