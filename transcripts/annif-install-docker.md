
Welcome to this Annif tutorial video.

Here we focus on Docker-based installation of Annif.

This approach is recommended for those already familiar with Docker

The tutorial page has step-by-step instructions, you can also read more from the Annif wiki

There a few things to consider with this approach:

Docker needs enough memory, you can allocate more from the advanced -tab in the settings

You’ll also need to be able to share a folder with Docker for the most seamless experience

This reguires adminstrator access, however, and as that might not be possible to obtain, there’s an alternative approach you can follow.


Installing Annif via Docker on Windows or Mac is as simple as running one of these commands here
docker run -v ~/Annif-tutorial:/Annif-tutorial --network host --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:tutorial
docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u $(id -u):$(id -g) quay.io/natlibfi/annif:tutorial


On windows the command looks like this docker run -v ~/Annif-tutorial:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u root quay.io/natlibfi/annif:tutorial

On windows especially as you might not be able to share a folder with Docker there is this alternative approach you can follow by running this slightly different command docker run -v Annif-tutorial-volume:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u root quay.io/natlibfi/annif:tutorial

 followed by this command run in another command shell docker cp data-sets/ annif:/Annif-tutorial


This is what installing annif via docker looks like on windows powershell

We run this command here - and it’s the modified version because we’re doing the alternative approach on windows docker run -v Annif-tutorial-volume:/Annif-tutorial -p 5000:5000 --name annif -it --rm -u root quay.io/natlibfi/annif:tutorial

When it finishes the command prompt changes

The next step, if you are doing the alternative approach on windows, is to navigate to the annif tutorial folder via the cd command and run this command docker cp data-sets/ annif:/Annif-tutorial

Then go back to the original command shell and check by running the ls command that the data-sets folder is where it should be

Then you should be good to go

Thank you for watching!
