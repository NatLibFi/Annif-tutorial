# Lesson 1: Install Annif

## 1. Install Annif

To be able to complete the exercises you need to install Annif on your own
computer. There are three options to choose from:

1. Docker based install
2. VirtualBox virtual machine image with preinstalled Annif
3. Local install using pip (Linux only)

We recommend the Docker install because it is the most convenient way of
getting Annif up and running with all the extra features enabled.

### 1.1. Docker based install

TBD

See [Usage with Docker](https://github.com/NatLibFi/Annif/wiki/Usage-with-Docker) in the
Annif wiki

## 1.2. VirtualBox based install

TBD

## 1.3. Local install

For this to work, you will need a Linux operating system (preferably Ubuntu
or Debian based) and Python 3.5, 3.6 or 3.7. This option is only recommended
if you are used to work with Python packages.

See the [Annif top level README file](https://github.com/NatLibFi/Annif/blob/master/README.md)

The basic install from PyPI only supports core features. You need to
install some optional extra features separately - see [Optional features and
dependencies]([https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies)
in the Annif wiki.

## 2. Verify that you can run Annif

Once you have installed Annif, check that it runs using the command:

    annif --help

If you get a usage message, congratulations - you're up and running!