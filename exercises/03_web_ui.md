# Exercise 3: Annif web user interface

Testing on the command line can be tedious, so Annif also provides a simple
web user interface.

## 1. Start up the web UI

Run the command:

    annif run

Annif will start up and keep running until you stop it (by pressing Ctrl-C).

## 2. Open the UI in the browser

Use your browser to access the URL 
[localhost:5000/](http://localhost:5000/) or [http://127.0.0.1:5000/](http://127.0.0.1:5000/), or if using Codespace, click the green "Open in Browser" button in the opened window.

You should see a simple user interface with a big empty text field.

In case of connection problems and you are using Docker, try using [http://192.168.99.100:5000/](http://192.168.99.100:5000/).

## 3. Test your project using the UI

Use the dropdown menu on the right to select the project you set up in the
previous lesson.

Type or paste some text into the big text field.

Press the "Get suggestions" button.

You should see a list of results on the bottom right.

## 4. Test on an example document

Open up the example document (PDF or txt) that you used for testing the
TFIDF project in the previous exercise. Copy all the text of the document
and paste it into the text field of the web UI. Then press the "Get suggestions"
button. Did you get similar results as when using the command line?

Try also using copying just the title of the document, or both the title and
abstract.

Congratulations! You've completed Exercise 3 and you can now easily test your
project with different input texts using the web UI. 

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
