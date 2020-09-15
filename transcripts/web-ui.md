Welcome to this Annif tutorial video.
In this video we will get to know the web user interface of Annif.

The command line is great for administrative tasks such as setting up and training Annif, but for simply testing Annif with various texts the command line is not so handy. For that purpose there exists the web user interface, which can be used in any web browser.

The web user interface is started on the command line. The command is
annif run 

If you are running Annif within a Docker container, you need to add also a host option
--host 0.0.0.0
The option can be added also when not using Docker.

The web UI is now running. If wanted, it could be stopped by pressing Control-C.

To use the web UI, I open a web browser, and go address localhost.
I use port 5000 by adding a colon and “5000”.
Here we find the Web UI. There is a big empty field where the text to get suggestions for can be typed or copy-pasted.
For example, here I copy-paste the introduction part from the Wikipedia article about the National Library of Finland.

On the right there is a menu for selecting a project, I select a TFIDF project.
The suggestions can be fetched by clicking this button.
Here are the suggested subjects. Each label acts as a web link to the URI, and the bars visualize the scores that Annif assigns to the suggestions.
The maximum number of shown suggestions can be selected with these buttons.
There is also a link to the interactive documentation of the API. The documentation shows some details of the methods of the Annif API.
This video demonstrated the web user Interface of Annif.
Thank you for watching!
