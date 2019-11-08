# Exercise 3: Annif web user interface

Testing on the command line can be tedious, so Annif also provides a simple
web user interface.

## 1. Start up the web UI

Run the command:

    annif run --host 0.0.0.0

Annif will start up and keep running until you stop it (by pressing Ctrl-C).

## 2. Open the UI in the browser

Use your browser to access the URL
[http://127.0.0.1:5000/](http://127.0.0.1:5000/)

You should see a simple user interface with a big empty text field.

In case of connection problems and you are using Docker, try using [http://192.168.99.100:5000/](http://192.168.99.100:5000/) instead of `localhost`. 

## 3. Test your project using the UI

Use the dropdown menu on the right to select the project you set up in the
previous lesson.

Type or paste some text into the big text field.

Press the Analyze button.

You should see a list of results on the bottom right.

Congratulations! You've completed Exercise 3 and you can now easily test your
project with different input texts using the web UI. 
