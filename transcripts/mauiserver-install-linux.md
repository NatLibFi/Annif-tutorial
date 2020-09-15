Welcome to this Annif tutorial video. In this video we will install Maui Server on a Linux system. 

Maui is a system for automated subject indexing, based on a lexical algorithm. It’s a Java-based tool that can be used with Annif through Maui Server, which is a REST API microservice wrapper for Maui.

This kind of native Linux installation of Maui Server is best suited to people who have some experience using Linux. As an alternative, you can install Maui Server as a Docker image instead. This video follows the installation steps that are also explained in the Annif wiki, on the page for the Maui backend.

To demonstrate the installation process, I’m using an Xubuntu 20.04 virtual machine running in VirtualBox, and I will set up Tomcat version 9 to run Maui Server. However, you can use any other general purpose Linux distribution, and also Tomcat version 8 should work with some small adjustments to the commands.


First we need to download the Maui Server software as a Web Application Resource or WAR file. Let’s open a web browser. [open firefox]  

It can be found on the Maven Central repository for Java software packages, so let’s go to search.maven.org

And enter “mauiserver”

And select the latest available version

Then click on Download and right-click on “war” and we’ll save it in the home directory

It takes a while to download, it’s about 90 megabytes

Now it’s done. Let’s close the browser. 

Now I’m opening a terminal window because the rest of the installation is done on the command line.

First we need to install Tomcat. I’m using version 9, but version 8 should work too. Installing Tomcat will also install a Java runtime in case you don’t have it already. Installing packages requires root permission so I’ll use sudo. We will also install the command line web client curl in the same go, as it will be needed later to verify the installation.

sudo apt install tomcat9 curl

Verify that Tomcat has started up:

service tomcat9 status



Now let’s create a data directory for Maui Server. 

sudo mkdir /var/lib/mauidata

We also need to give Tomcat permissions to read and write files within that directory:

sudo chown tomcat:tomcat /var/lib/mauidata

Then we need to do a little bit of configuration using a text editor. I will use the text-based editor nano that comes with Ubuntu, but you can use any editor you like. Let’s open the configuration file for Tomcat:

sudo nano /etc/default/tomcat9

Now there are two things to take care of.
First we need to ensure that Tomcat gets enough heap memory to be able to run Maui Server. It usually needs around a gigabyte, so it we give it two gigabytes it should be enough. So let’s change the JAVA_OPTS setting like this:

-Xmx2G

Then we also need to tell Maui Server where to find the data directory. Let’s also add the setting to JAVA_OPTS:

-DMauiServer.dataDir=/var/lib/mauidata

Now let’s save the file and exit the editor.

One more thing: Under recent Ubuntu and Debian releases, Tomcat 9 is running in a sandbox set up using systemd, which is managing system services. The sandbox limits which parts of the file system web apps can access. We need to allow Tomcat to access the data directory. To do so, we have to customize the systemd unit file, which defines the service. We can look at the default unit file using the command

less /lib/systemd/system/tomcat9

Here we can find a setting ProtectSystem=strict, which means that only specific paths can be accessed, and these are given using ReadWritePaths settings. We need to allow also the data directory. So let’s customize it using the command

sudo systemctl edit tomcat9

This brings up a text editor with an empty file. Here we can override settings in the default unit file. Let’s create a Service section:

[Service]

and allow accessing the data directory:

ReadWritePaths=/var/lib/mauidata

Then let’s put the WAR file into the Tomcat webapps directory, which means that Tomcat will deploy it. 

sudo cp mauiserver-1.3.2.war /var/lib/tomcat9/webapps/mauiserver.war

We’ll rename it to drop the version number here, because the name of the WAR file determines the base URL that the webapp will have, and it’s usually more convenient not to have a version number in the URL.

Then we need to restart Tomcat for the new settings to take effect:

sudo service tomcat9 restart

Finally let’s verify that Maui Server is running properly. It provides a REST API over the web, so we can try to access it with the command line tool curl. You could also use a web browser instead.

curl http://localhost:8080/mauiserver/

It gives a JSON response explaining what it is and how it’s configured. If you get this, then everything should be okay! If not, check the Tomcat log files under /var/log/tomcat9 .

Now we are finished installing Maui Server. Thank you for watching!
