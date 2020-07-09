# Exercise 5: Set up and train a Maui project

In this lesson, we will set up a Maui project. Maui is a great tool for
lexical automated subject indexing, i.e. matching terms in document text to
terms in a controlled vocabulary.

Maui can be used with Annif through Maui Server, which is a REST API wrapper
around the Maui codebase. Thus you need to install Maui Server first (unless
you use the VirtualBox image, where this has already been taken care of).
There are two ways of doing this:

1. Use the Docker image of Maui Server. This is the easiest option if you
have Docker on your system.
2. Set up the Tomcat application server, download the Maui Server WAR file
which contains a pre-packaged webapp, and place the WAR under the `webapps`
directory of Tomcat. See the [Annif
wiki](https://github.com/NatLibFi/Annif/wiki/Backend%3A-Maui) for details.

## 1. Make sure Maui Server is up and running

If you have Maui Server running under Tomcat, no further setup is needed.

If you are running Annif with Docker (on any platform, _Linux/MacOS/Windows_), open a new terminal window and start up Maui Server with (this will first download the Docker image if it does not yet exist locally):

    docker run -v Maui-data-volume:/mauidata -p 8080:8080 --name mauiserver --rm -e MAUI_SERVER_DATA_DIR=/mauidata quay.io/natlibfi/mauiserver


Try to access the URL [http://localhost:8080/mauiserver/](http://localhost:8080/mauiserver/) using
a web browser or a tool such as `curl`. If you get a JSON response that
begins with `title: "Maui Server"`, you're good to go!

## 2. Define a Maui project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

If you use the `yso-nlf` data set, use the following snippet:

    [yso-maui-en]
    name=YSO Maui project
    language=en
    backend=maui
    vocab=yso-en
    endpoint=http://localhost:8080/mauiserver/
    #endpoint=http://host.docker.internal:8080/mauiserver/
    tagger=yso-maui-en

If you use the `stw-zbw` data set, use the following snippet:

    [stw-maui-en]
    name=STW Maui project
    language=en
    backend=maui
    vocab=stw-en
    endpoint=http://localhost:8080/mauiserver/
    #endpoint=http://host.docker.internal:8080/mauiserver/
    tagger=stw-maui-en

**Note**: In case you are using Docker on _Windows_ or _MacOS_, use the line with `host.docker.internal` inplace of the one with `localhost`. (The line starting with a `#` is _not_ used, also note that you cannot have both lines without a `#` in the `projects.cfg` -file.)

## 3. Train the project

Now we can train the project. Maui requires a relatively small number
(hundreds or at most a few thousand) of training documents, which should be
as similar as possible in structure to the documents it will later be
applied on.

We will therefore use full text documents to train Maui. For the
`yso-nlf` data set, we will use around 350 Master's and doctoral
theses in the
[`yso-nlf/docs/validate/`](../data-sets/yso-nlf/docs/validate)
directory. For the `stw-zbw` data set, we will use around 600 articles
in the corresponding
[`stw-zbw/docs/validate/`](../data-sets/stw-zbw/docs/validate)directory.

If you use the `yso-nlf` data set, run this command:

    annif train yso-maui-en data-sets/yso-nlf/docs/validate/

If you use the `stw-zbw` data set, run this command:

    annif train stw-maui-en data-sets/stw-zbw/docs/validate/

Training should take around a minute.

## 4. Test the project on sample text

Once training is completed, we can try the model on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest yso-maui-en

If you use the `stw-zbw` data set, run this command:

    echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest stw-maui-en

## 5. Test the project on an example document

Try asking for subject suggestions from the Maui project to the same
document that you used in Exercise 2 (TFIDF project).

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-maui-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-maui-en <data-sets/stw-zbw/docs/test/10008797547.txt

You can also try the Web UI with this Maui based project.

## 6. Evaluate the project on a collection of documents

If you use the `yso-nlf` data set, run this command:

    annif eval yso-maui-en data-sets/yso-nlf/docs/test/

If you use the `stw-zbw` data set, run this command:

    annif eval stw-maui-en data-sets/stw-zbw/docs/test/

Evaluation should take 1-2 minutes. Write down the F1@5 and NDCG scores and
compare them with the scores that the TFIDF project got.

Congratulations, you've completed Exercise 5, you have a working Maui project
and you know how well it performs compared to the TFIDF project!

---

<p align="center">
<a href="/exercises/04_evaluate.md">« Previous</a> |
<a href="/exercises/06_ensemble_project.md">Next »</a>
</p>
