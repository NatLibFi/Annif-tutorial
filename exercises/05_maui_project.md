# Exercise 4: Set up and train a Maui project

In this lesson, we will set up a Maui project. Maui is a great tool for
lexical automated subject indexing, i.e. matching terms in document text to
terms in a controlled vocabulary.

Maui can be used with Annif through Maui Server, which is a REST API wrapper
around the Maui codebase. Thus you need to install Maui Server first. There
are two ways of doing this:

1. Use the Docker image of Maui Server. This is the easiest option if you
have Docker on your system.
2. Set up the Tomcat application server, download the Maui Server WAR file
which contains a pre-packaged webapp, and place the WAR under the `webapps`
directory of Tomcat.

## 1. Make sure Maui Server is up and running

If you are running Annif with Docker, start up Maui Server with:

_Linux/OSX_:

    docker run -v Maui-data-volume:/mauidata -p 8080:8080 --name mauiserver --rm -e MAUI_SERVER_DATA_DIR=/mauidata -e MY_UID=$(id -u) -e MY_GID=$(id -g) mauiserver

_Windows_:

    docker run -v Maui-data-volume:/mauidata -p 8080:8080 --name mauiserver --rm -e "MAUI_SERVER_DATA_DIR=/mauidata" -e "MY_UID=0" -e "MY_GID=0" mauiserver

If you have Maui Server running under Tomcat, you can access the URL
[http://localhost:8080/mauiserver/](http://localhost:8080/mauiserver/) using
a web browser or a tool such as `curl`. If you get a JSON response that
begins with `title: "Maui Server"`, you're good to go!

## 2. Define a Maui project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

If you use the `yso-finna-theses` data set, use the following snippet:

    [yso-maui-en]
    name=YSO Maui project
    language=en
    backend=maui
    vocab=yso-en
    endpoint=http://localhost:8080/mauiserver/
    tagger=yso-maui-en

If you use the `stw-zbw` data set, use the following snippet:

    [stw-maui-en]
    name=STW Maui project
    language=en
    backend=maui
    vocab=stw-en
    endpoint=http://localhost:8080/mauiserver/
    tagger=stw-maui-en

## 3. Train the project

Now we can train the project. Maui requires a relatively small number
(hundreds or at most a few thousand) of training documents, which should be
as similar as possible in structure to the documents it will later be
applied on.

We will therefore use full text documents to train Maui. For the
`yso-finna-theses` data set, we will use around 350 Master's and doctoral
theses in the
[`yso-finna-theses/docs/validate/`](../data-sets/yso-finna-theses/docs/validate)
directory. For the `stw-zbw` data set, we will use around 600 articles
in the corresponding
[`stw-zbw/docs/validate/`](../data-sets/stw-zbw/docs/validate)directory.

If you use the `yso-finna-theses` data set, run this command:

    annif train yso-maui-en data-sets/yso-finna-theses/docs/validate/

If you use the `stw-zbw` data set, run this command:

    annif train stw-maui-en data-sets/stw-zbw/docs/validate/

Training should take around a minute.

## 4. Test the project

Once training is completed, we can try the model on some example sentence.

If you use the `yso-finna-theses` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest yso-maui-en

If you use the `stw-zbw` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest stw-maui-en

You can also try the Web UI with this Maui based project.

Congratulations, you've completed Exercise 4 and you have a working Maui project!
