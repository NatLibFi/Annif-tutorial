# Exercise 1: Install Annif

## 1. Install Annif

To be able to complete the exercises you need to install Annif on your own
computer. There are three options to choose from:

1. Docker based install
2. VirtualBox virtual machine image with preinstalled Annif
3. Local install using pip (Linux only)

We recommend the Docker install because it is the most convenient way of
getting Annif up and running with all the extra features enabled.

### 1.1. Docker based install

Copy the `Annif-tutorial` directory from the USB stick to your computer's home directory.

Using a terminal of your system (i.e. PowerShell in _Windows_), go to `Annif-tutorial` directory and load the Docker images in Docker:

    docker load -i annif-0.43.1.tar

and 

    docker load -i mauiserver.tar

You can check with `docker images` that the images `quay.io/natlibfi/annif:0.43.1` and `mauiserver` are now available.

Start the bash shell in a Docker container:

_Linux/OSX_:

    docker run -v ~/Annif-tutorial-volume:/Annif-tutorial -p 5000:5000 -w /Annif-tutorial --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:0.43.1 bash

_Windows_ (replace `your_user_name` appropriately):

    docker run -v /c/Users/your_user_name/Annif-tutorial:/Annif-tutorial -p 5000:5000 -w /Annif-tutorial --name annif -it --rm quay.io/natlibfi/annif:0.43.1 bash

In the shell you now have the Annif installation ready, and the `Annif-tutorial` directory and its contents should be available. List the contents with `ls`.

In case the directory is empty or other problems, try replacing the `-v ...` option in above command with `-v Annif-tutorial-volume:/Annif-tutorial`. Then, in another shell window, go to `Annif-tutorial` directory and run `docker cp data-sets/ annif:/Annif-tutorial`. In the container, check with `ls` that the `data-sets` directory is now  copied there.

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
