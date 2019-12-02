# Exercise 1: Install Annif

## 1. Install Annif

To be able to complete the exercises you need to install Annif on your own
computer. There are three options to choose from:

1. VirtualBox virtual machine image with preinstalled Annif
2. Docker based install
3. Local install using pip (Linux only)

### 1.1. VirtualBox based install

First make sure that you have the [VirtualBox](https://www.virtualbox.org/)
host software for your operating system installed. You only need the basic
install; the Extension Pack or SDK modules are not necessary.

You will be given a USB stick with a `VirtualBox VMs` folder. Inside this
folder is another folder called `annif-tutorial`. You need to copy this
folder into the `VirtualBox VMs` folder below your home directory. If it
doesn't exist yet, you can create it yourself.

Start up the VirtualBox software.  From the menu bar of the main window,
select Machine -> Add... and navigate to the `annif-tutorial` folder on your
hard drive (not the USB stick) and open the `annif-tutorial.vbox` file. The
`annif-tutorial` machine should now appear at the list of VMs on the left
side. Select it and press Start. A new window should appear and after a
while, you should see a Linux (Xubuntu) desktop. Open a terminal window (by
double-clicking on the Terminal desktop icon). You can also change the
keyboard layout now from the upper right corner (click the US flag).


### 1.2. Docker based install

First, copy the `Annif-tutorial` directory from

_Windows_ and _MacOS_ users should make sure [the available memory](https://docs.docker.com/docker-for-windows/#advanced) for Docker is at least 8 GB (click the whale icon in the notification area, and select Settings -> Advanced).



Start the bash shell in a Docker container:

_Linux_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial --network host --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:0.44-tutorial

_Windows_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u root quay.io/natlibfi/annif:0.44-tutorial

In case of troubles, try the following, replacing `your_user_name` appropriately:
      
      docker run -v  /c/Users/your_user_name/Annif-tutorial:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u root quay.io/natlibfi/annif:0.44-tutorial

_MacOS_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:0.44-tutorial

In the shell you now have the Annif installation ready, and the `Annif-tutorial` directory and its contents (the same as in the host system) should be available (don't care about the part `I have no name!` in the prompt). Check this with `ls`, and if you see the same contents, you are ready with the install! When you have finished the excercices, you can get out of the container shell with `exit` command.

#### Alternative approach using [named volume](https://docs.docker.com/storage/volumes/)
In case of problems related to sharing a drive for Docker, you can first check that [the sharing is enabled from the Docker settings](https://docs.docker.com/docker-for-windows/#shared-drives). If sharing is not possible, the `Annif-tutorial` directory is empty, or other problems occur, exit the container, and start it again with

    docker run -v Annif-tutorial-volume:/Annif-tutorial --network host --name annif -it --rm -u root quay.io/natlibfi/annif:0.44-tutorial
    
Then, open a new terminal window on the host system, go again to the `Annif-tutorial` directory, and copy the `data-sets` directory to the container's volume with

    docker cp data-sets/ annif:/Annif-tutorial

In the container shell, check with `ls` that the directory is now there. In the following excercises, when editing a file is needed, it should be done within the container using `nano` editor; e.g. open `projects.cfg` using
    
    nano projects.cfg


#### A brief nano guide
You can paste text to the window e.g. by right-clicking on the terminal. Move around using arrow buttons. Save the text by `ctrl+O` (hit `Enter` to confirm file name). Exit nano by `ctrl+X`.
(Find out more from the [quide](https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/).)


### 1.3. Local install

For this to work, you will need a Linux operating system (preferably Ubuntu
or Debian based) and Python 3.5, 3.6 or 3.7. This option is only recommended
if you are used to work with Python packages.

See the [Annif top level README file](https://github.com/NatLibFi/Annif/blob/master/README.md)

The basic install from PyPI only supports core features. You need to
install some optional extra features separately - see [Optional features and
dependencies]([https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies)
in the Annif wiki.

## 2. Verify that you can run Annif

Once you have installed Annif and have opened a command line terminal
window, check that Annif runs using the command:

    annif

If you get a usage message, congratulations - you're up and running!
