Welcome to this Annif tutorial video. This video demonstrates the use of VirtualBox for running Annif. 

VirtualBox is a software for running virtual machines on a host computer. A virtual machine can have an operating system, which is completely different to the one running on the host. For example, the guest operating system can be Linux, while the host is using Windows or MacOS.  

VirtualBox allows to save the whole virtual machine as an image. The image can be copied, transferred, and opened in another host computer with VirtualBox software.

So for running the machine image containing Annif the VirtualBox software needs to be  installed on your computer. Instructions for installation can be found for example from the VirtualBox website. The basic VirtualBox install is enough.

The VirtualBox machine image that is based on Xubuntu and contains preinstalled Annif and all the files needed in this tutorial can be downloaded from the annif.org website. The zip file to download is about 2 GBs so it can take a while to download. 

Running this machine image in VirtualBox is all that is needed for this tutorial, and this an easy way to get access to Annif and the materials that are needed in this tutorial.

Here I demonstrate the usage of the VirtualBox to run the Annif machine image. My host computer is running Windows, but the steps are similar in any operating system.

I have already downloaded the zip file of the image. Now I create a folder with the name “VirtualBox VMs” in my home directory. Then I extract the contents of the zip file to the folder. This can take a few minutes.

Once the archive is extracted, I start the VirtualBox software. To open the image, I go to the “Machine” menu and select “Add”. From the “VirtualBox VMs” folder I go the “annif-tutorial” folder and I open the “annif-tutorial.vbox” file. Now the list on the left shows the “annif tutorial” virtual machine. I start it with the button with the green arrow.

The virtual machine opens in a new window, and soon it displays the Xubuntu desktop. On the desktop there are shortcuts to a web browser and to a text editor, which are useful in the exercises of this tutorial. For using Annif, I open a terminal window. Here I can now type Annif commands:

annif

I can also copy some text from the host to clipboard, for example from a web page. And then I can paste the text to the terminal window:

annif list-projects

For pasting to the terminal I needed to use the control-shift-V key combination.

The virtual machine can be shut down from the main menu.

One more thing: There is a known problem on some Windows hosts that makes Annif crash showing an error message about illegal instruction (core dumped). On the exercise page there are instructions for ways how this can be solved.

You have now seen how to install Annif using VirtualBox. Thank you for watching!
