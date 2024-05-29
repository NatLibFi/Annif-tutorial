# Exercise 1: Install Annif

## 1. Install Annif

To be able to complete the exercises you need to install Annif on your own
computer or GitHub Codespaces. There are four options to choose from:

1. VirtualBox virtual machine image with preinstalled Annif
2. Docker based install
3. Local install using pip (Linux only)
4. Install to GitHub Codespaces

### 1.1. VirtualBox based install

First make sure that you have the [VirtualBox](https://www.virtualbox.org/)
host software for your operating system installed. You only need the basic
install; the Extension Pack or SDK modules are not necessary.

The VirtualBox image is a preconfigured virtual machine containing a minimal
installation of Xubuntu, Annif, and the files needed for this tutorial.

Download the VirtualBox image `annif-tutorial-vbox.zip` from the [annif.org/download
folder](https://annif.org/download/).  This is a ~2GB
zip archive so it can take a while to download.  Find the `VirtualBox VMs`
folder below your home folder; if it doesn't exist yet (i.e. you've just
installed VirtualBox and haven't created any VMs yet), you can create it
yourself. Extract the `annif-tutorial` folder from the zip archive into the
`VirtualBox VMs` directory; it will initially take around 6GB disk space
when uncompressed and grow in size (up to 20GB) as you add more data and
train models.

Start up the VirtualBox software.  From the menu bar of the main window,
select Machine -> Add... and navigate to the `annif-tutorial` folder on your
hard drive (under `VirtualBox VMs`) and open the `annif-tutorial.vbox` file. The
`annif-tutorial` machine should now appear at the list of VMs on the left
side. Select it and press Start. A new window should appear and after a
while, you should see a Linux (Xubuntu) desktop. Open a terminal window (by
double-clicking on the Terminal desktop icon). You can also change the
keyboard layout now from the upper right corner (click the US flag). Other 
keyboard layouts can be installed from the top left corner menu 
(Settings -> Keyboard -> Layout tab, where you can add and remove layouts).

_Troubleshooting:_ If Annif fails to start and the error message shows 
`Illegal instruction (core dumped)` on a Windows host, the probable cause 
is that [AVX support](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions) 
is not available inside the virtual machine. Here are two ways that can be 
tried solve the problem:

1. Make the AVX support available by tweaking Windows settings ([from VirtualBox forum](https://forums.virtualbox.org/viewtopic.php?f=1&t=62339#p417512), also other messages in the thread can be worth reading): 
    - Hyper-v competes for resources and needs to be disabled. To check the status of Hyper-v in Windows 10, *right click start | Run | `OptionalFeatures.exe`*, and look for the "Hyper-V" option. The box should be empty, not checked or shaded. If you want to be absolutely sure that Hyper-v is gone then open an administrator command console and type `bcdedit /set hypervisorlaunchtype off`. Make sure to fully power down and reboot the host after changing the Hyper-v setting.
    - On some Windows hosts with an EFI BIOS, DeviceGuard or CredentialGuard may be active by default, and interferes with OS level virtualization apps in the same way that Hyper-v does. These features also need to be disabled. On Pro versions of Windows you can do this using `gpedit.msc` (set *Local Computer Policy > Computer Configuration > Administrative Templates > System > Device Guard > Turn on Virtualization Based Security* to *Disabled*. CredentialGuard is a subset of DeviceGuard, so disabling the former should be enough. If you cannot use gpedit for some reason then the equivalent registry hack is to find the key *HKLM|SYSTEM|CurrentControlSet|Control|DeviceGuard|EnableVirtualizationBasedSecurity|Enabled* and set it to *0*.

2. Remove the need for AVX by uninstalling TensorFlow package. This is simple, however it means that neural network ensemble models can not be used and (optional) exercises [10](/exercises/10_nn_ensemble_project.md) and [11](/exercises/11_incremental_learning.md) completed. In a terminal window run the command `pip uninstall tensorflow-cpu` and confirm uninstallation by pressing `y`. 

### 1.2. Docker based install

First, to get the data sets for the exercises (if you do not have them already), either download this GitHub repository as [a zip archive ](https://github.com/NatLibFi/Annif-tutorial/archive/master.zip) or git clone it. Place the `Annif-tutorial` directory in your home directory (in _Windows_ to `C:\Users\your_username`), or to a location of your choice, but in that case change the mount location in below commands appropriately.

_Windows_ and _MacOS_ users should make sure [the available memory](https://docs.docker.com/docker-for-windows/#advanced) for Docker is at least 8 GB (click the whale icon in the notification area, and select Settings -> Advanced).

Start the bash shell in a Docker container with Annif using the following command (this will also download the `annif:tutorial` Docker image from https://quay.io/natlibfi/annif):

_Linux_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial --network host --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:tutorial

_Windows_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 -p 8888:8888 --name annif -it --rm -u root quay.io/natlibfi/annif:tutorial

_MacOS_:

    docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 -p 8888:8888 --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:tutorial

In the shell you now have the Annif installation ready, and the `Annif-tutorial` directory and its contents (the same as in the host system) should be available (don't care about the part `I have no name!` in the prompt). Check this with `ls`, and if you see the same contents, you are ready with the install! When you have finished the excercices, you can get out of the container with `exit` command. Note the tilde character (`~`) in the beginning of path with the `-v` option; that is important for directory mounting to work (it means the user's home directory). 

For more information about using Annif with Docker see [Annif wiki](https://github.com/NatLibFi/Annif/wiki/Usage-with-Docker#running-annif-in-docker-container) and [Docker documentation](https://docs.docker.com/engine/reference/commandline/run/). Information for more production-ready configurations with `docker-compose.yml` files can be found from the [api-instances branch](https://github.com/NatLibFi/Annif/tree/api-instances) of Annif repository.

#### Alternative approach using [named volume](https://docs.docker.com/storage/volumes/)
In case of problems related to sharing a drive for Docker, you can first check that [the sharing is enabled from the Docker settings](https://docs.docker.com/docker-for-windows/#shared-drives). If sharing is not possible, the `Annif-tutorial` directory is empty, or other problems occur, exit the container, and start it again with a modified command, where the `-v ~/Annif-tutorial:/Annif-tutorial` option is replaced with `-v Annif-tutorial-volume:/Annif-tutorial` (note the `~/` is dropped from the beginning).
    
Then, open a new terminal window on the host system, `cd` to the `Annif-tutorial` directory, and copy the `data-sets` directory to the container's volume with

    docker cp data-sets/ annif:/Annif-tutorial

In the container shell, check with `ls` that the directory is now there. In the following excercises, when editing a file is needed, it should be done within the container using `nano` editor; e.g. open `projects.cfg` using
    
    nano projects.cfg


#### A brief nano guide
You can paste text to the window e.g. by right-clicking on the terminal. Move around using arrow buttons. Save the text by `ctrl+O` (hit `Enter` to confirm file name). Exit nano by `ctrl+X`.
(Find out more from the [guide](https://www.howtogeek.com/howto/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/).)

#### Removing a container 

The `--rm` option in the run commands should ensure that the container is removed when it is exited (but the data in the `Annif-tutorial` directory is retained as it is mounted from the host or from the named volume). However, in _Windows_ the container removing sometimes does not work, and restarting the container fails (`The container name XXX is already in use by...`). In this case, use command `docker rm -f XXX` to manually remove it.

### 1.3. Local install

For this to work, you will need a Linux operating system (preferably Ubuntu or Debian based) and Python 3.9, 3.10, 3.11 or 3.12. This option is only recommended if you are used to work with Python packages.

See the [Annif top level README file](https://github.com/NatLibFi/Annif/blob/master/README.md)

The basic install from PyPI only supports core features. You also need to
install the Omikuji feature separately to complete the Omikuji based
exercises and the neural network (nn) feature for the NN ensemble exercises - see [Optional features and
dependencies](https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies)
in the Annif wiki for details.

### 1.4. GitHub Codespaces install

In this installation you will be using Annif in a GitHub hosted machine, which you will access via a terminal in your browser.
For this you are required to have an account on GitHub.

1. Open a page to configure a new codespace by clicking this badge:

    [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/NatLibFi/Annif-tutorial/tree/codespaces)

2. Select "4-core" for "Machine type" (the bottommost menu); other selections can be left to default values
3. Click the green "Create codespace" button on bottom of the page 

This will start a start a new codespace session, and Annif and some other packages will be installed to it (`Running postCreateCommand...`), which can take about 5 mins.

After this everything is set up: a panel for the terminal screen is on the lower right corner on your browser window; you probably want to make that panel bigger by dragging from its edges.

## 2. Verify that you can run Annif

Once you have installed Annif and have opened a command line terminal
window, check that Annif runs using the command:

    annif

If you get a usage message, congratulations - you're up and running!

### Shell completions
You can also check that the tab-key completion works (in the case of local install the support for it first needs to be enabled, [see instructions](https://github.com/NatLibFi/Annif#shell-compeletions)).

You can complete e.g. the `list-*` commands by entering some characters from the beginning of the command and pressing tab, which completes the `list-` part:

    annif li<TAB>
    annif list-

Then, by pressing tab twice, you get suggestions for possible endings:

    annif list-<TAB><TAB>
    list-projects  list-vocabs
    annif list-

Then continuing the command with just `p` character (or by `v` for vocabs) and pressing tab, you get the full command:

    annif list-p<TAB>
    annif list-projects

The completion works for commands, options and paths as well as for project and vocabulary ids.

## More information

For more information, see the documentation in the Annif wiki:

* [System requirements](https://github.com/NatLibFi/Annif/wiki/System-requirements)
* [Optional features and dependencies](https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies)
* [Usage with Docker](https://github.com/NatLibFi/Annif/wiki/Usage-with-Docker)

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
