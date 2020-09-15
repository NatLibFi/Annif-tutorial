Welcome to this Annif tutorial video

In this video, we’ll use maui - a tool for lexical automated subject indexing

i.e. matching terms in a document text to terms in a controlled vocabulary

In Annif, Maui can be used through Maui Server, a wrapper around the Maui codebase.
This means that Maui Server needs to be installed first before it can be used in Annif
if you are using virtualbox, this installation has been taken care of for you
You can follow the instructions in the previous tutorial videos and the instructions on the tutorial page to install Maui.
You can use maui through docker by running this command
Docker installation is covered in it’s own tutorial video 
There is also the possibility of a native install on Linux - this is also covered elsewhere in the tutorial as we as on the annif wiki
You can first verify that maui is working before moving on to training

Go to this URL and, you should see a json response like this if everything is ok

Then let’s move on to training

First, we edit the projects.cfg file by adding the maui project

Note that for Docker on Windows or Mac, the endpoint is different

Next, we train maui with some documents. 

Maui requires a relatively small amount of training data

A usual raining should be done with similar documents to those we will use in testing. 

You can run the training using the annif train command

Note that we’ll use fulltext documents in the validate folder

The next step is to try out the model

First, we can use  just a short sample text and give it to the  annif suggest -command

We can also try annif suggest with a single document before moving on to a full corpus

Next, we’ll evaluate a corpus with the annif eval command

After running the command we should see the results.

Thank you for watching!
