Welcome to this Annif tutorial video. In this video we will install Maui Server on a Linux system using Docker. 

Maui is a system for automated subject indexing, based on a lexical algorithm. It’s a Java-based tool that can be used with Annif through Maui Server, which is a REST API microservice wrapper for Maui.

Docker allows running pre configured applications in an environment that is isolated from the rest of the system.
This enables us to run Maui Server with only little configuration.

The demonstration of the installation process will use Xubuntu.
However, It should be the same for other Linux Distributions as long as you have Docker installed. You can find instructions for doing so on docker.com or by entering docker installation into a search engine.

Start  by pulling the docker image for maui server
> docker pull quay.io/natlibfi/mauiserver

Now we can start the docker container:

> docker run 
 Set environment variables that are present inside the docker container
first the user id
>continued> -e MY_UID=$(id -u)

And also the group id
>continued> -e MY_GID=$(id -g)

Then we need to make sure that the container can store the data in a place that is accessible to other instances of the image
>continued> -v maui-data-volume:/mauidata

To allow processes on  the host system, like Annif, access to the MauiServer instance running inside the container the port needs to be exposed.
>continued> -p 127.0.0.1:8080:8080

We need to make sure that the container is deleted after its exits, otherwise it will fill up space.
>continued>--rm

Finally we need to give the name of the image the container should be created from.
>continued>quay.io/natlibfi/mauiserver




Finally let’s verify that Maui Server is running properly. It provides a REST API over the web, so we can try to access it with the command line tool curl. You could also use a web browser instead. We need to open a new terminal as the current one is running mauiserver.

curl http://localhost:8080/mauiserver/

It gives a JSON response explaining what it is and how it’s configured. If you get this, then everything should be okay!

Note that Maui Server will not be reachable anymore when closing the terminal window it runs in.
We will now terminate mauiserver by pressing ctrl+c
Going back to the other terminal window we press the up arrow to retrieve the curl command from the history.

The resulting error is due to the stopped Maui Server instance.

You can also run MauiServer in the background.
Switching the terminal we use the up arrow to retrieve the command for starting mauiserver.
Then navigate the cursor in front of the image name by pressing the left arrow.
We add -d to indicate that the container will run as a background process.
Furthermore we give the container a name to easily reference it later on.
>continues> --name tutorial-mauiserver
By pressing the up arrow we will again retrieve the curl command.
This time it returns with a success response.
We can stop the container by running
Docker kill tutorial-mauiserver



Now we are finished installing and running Maui Server using Docker.. Thank you for watching!
