# Exercise 2: Set up and train a TFIDF project

[![Video](/img/tfidf-project-slides-1.png)](https://youtu.be/Hwl6PUoG_hc)

- [slides](/presentations/tfidf-project-slides.pdf)
- [transcript of video](/transcripts/tfidf-project.md)

Annif requires you to set up one or more **projects** before you can use it.
A project is a set of configuration settings and (usually) some data files
such as a trained machine learning model. A project is identified by a
**project id**, which is typically a short string such as "yso-tfidf-en".

Projects are defined in a configuration file called `projects.cfg`. Annif
looks for a `projects.cfg` file in the current working directory unless you
tell it otherwise using either the `-p` command line option or the
`ANNIF_PROJECTS` environment variable. For the rest of this tutorial, we
will be using a working directory.

In this lesson, we will set up the simplest kind of Annif project, which
uses a TFIDF model that needs to be trained on example documents and/or
metadata records before it can be used. 

You need to choose which data set you want to use: either the
[yso-nlf](../data-sets/yso-nlf) data set from the National
Library of Finland or the [stw-zbw](../data-sets/stw-zbw) data set from ZBW.
Either one will work, but you need to be consistent.

## 1. Create a `projects.cfg` file

Use a text editor to create a `projects.cfg` file within the Annif-tutorial 
directory.

If you use the `yso-nlf` data set, use the following contents:

    [yso-tfidf-en]
    name=YSO TFIDF project
    language=en
    backend=tfidf
    vocab=yso
    analyzer=snowball(english)

If you use the `stw-zbw` data set, use the following contents:

    [stw-tfidf-en]
    name=STW TFIDF project
    language=en
    backend=tfidf
    vocab=stw
    analyzer=snowball(english)

## 2. Test that Annif can read the `projects.cfg` file

On the CLI, go to the Annif-tutorial directory (where you put the `projects.cfg`
file) using the `cd` command and run this command:

    annif list-projects

You should see a list with one entry, which is your defined project.

## 3. Load the vocabulary

Annif needs to know the vocabulary to use. We will load it from a SKOS file.

If you use the `yso-nlf` data set, run this command:

    annif load-vocab yso data-sets/yso-nlf/yso-skos.ttl

If you use the `stw-zbw` data set, run this command:

    annif load-vocab stw data-sets/stw-zbw/stw-skos.ttl

This should take less than 2 minutes for YSO and less than a minute for
STW. No output means the operation was succesful.

You only have to do this once for a particular vocabulary. You can now reuse
the same vocabulary (by using the same `vocab=` value) in other projects.

Note that in Annif versions older than 0.59 the command for loading a vocabulary was `loadvoc` and it expected a project id as an argument, not a vocabulary id.

## 4. Train the project using sample data

Now we can train the project. We will use training files that contain titles
and subjects extracted from metadata records (around 2 million for
`yso-nlf` and 1 million for `stw-zbw`). However, we will first try
with just a small training file based on 100,000 records to test the
process.

If you use the `yso-nlf` data set, run this command:

    annif train yso-tfidf-en data-sets/yso-nlf/yso-finna-small.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz-small.tsv.gz

Training should take around a minute.

## 5. Test the project

Once training is completed, we can try the model on some example sentence.

If you use the `yso-nlf` data set, run this command:

    echo "Machine learning algorithms build a mathematical model based on sample data" | annif suggest yso-tfidf-en

If you use the `stw-zbw` data set, run this command:

    echo "Machine learning algorithms build a mathematical model based on sample data" | annif suggest stw-tfidf-en

You can of course try any sentence or even just a single word.

## 6. Train the project using the full training data

Now that the basic model works, you can retrain it using the complete
training data sets. 

If you use the `yso-nlf` data set, run this command:

    annif train yso-tfidf-en data-sets/yso-nlf/yso-finna.tsv.gz

If you use the `stw-zbw` data set, run this command:

    annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz.tsv.gz

This should take around 5-10 minutes for the `stw-zbw` data
set and around 10-15 minutes for the `yso-nlf` data set.

After retraining, you can try the `suggest` command again.

## 7. Test on an example document

For this step, you will need the full text documents of your data set.  If
you have not already done so, you need to download the PDFs and convert them
to text files.

If you use the `yso-nlf` data set, run these commands:

    cd data-sets/yso-nlf/docs/
    make -j4 -k
    cd -

If you use the `stw-zbw` data set, run these commands:

    cd data-sets/stw-zbw/docs/
    make -j4 -k
    cd -

The downloading and conversion can take an hour or more, depending on your
Internet connection and CPU performance. The `-j4` option specifies the number of
downloads and conversions to perform in parallel.  The final `cd -` command
should take you back to the `Annif-tutorial` directory.

Pick any document from the `docs/test/` folder **of your chosen data set**. In
this example we will use the lowest-numbered documents, i.e. `2017-D-52518`
for `yso-nlf` and `10008797547` for `stw-zbw`. Open the `.txt` file of your
chosen document in a text editor, or alternately, look at the URL stored in
the corresponding `.url` file and open that URL in a web browser, which
should give you the original PDF version of that document. Then open the
corresponding `.tsv` file, which contains the subjects that have been
manually assigned to that document. Direct links for the first documents in
each set:

* yso-nlf: 2017-D-52518 "New Insights on the Role of Ecology and Life-history in Social Evolution" (doctoral dissertation of Piret Avila) [PDF](https://jyx2.jyu.fi/dspace/bitstream/handle/123456789/52518/978-951-39-6906-6_vaitos_20170113.pdf), [subjects](https://github.com/NatLibFi/Annif-tutorial/blob/master/data-sets/yso-nlf/docs/test/2017-D-52518.tsv)
* stw-zbw: 10008797547 "Entrepreneurship is not a Binding Constraint on Growth and Development in the Poorest Countries" (article by Wim Naudé) [PDF](https://www.econstor.eu/bitstream/10419/45166/1/616078927.pdf), [subjects](https://github.com/NatLibFi/Annif-tutorial/blob/master/data-sets/stw-zbw/docs/test/10008797547.tsv)

Now ask Annif for subject suggestions to the same document.

If you use the `yso-nlf` data set, run this command:

    annif suggest yso-tfidf-en <data-sets/yso-nlf/docs/test/2017-D-52518.txt

If you use the `stw-zbw` data set, run this command:

    annif suggest stw-tfidf-en <data-sets/stw-zbw/docs/test/10008797547.txt

Compare the output you got from Annif with the original, manually assigned
subjects. Was it close? Did Annif come with reasonable suggestions or not?

Congratulations, you've completed Exercise 2, you have a working project and
you know how to use it to suggest subjects for documents!

## More information

For more information, see the documentation in the Annif wiki:

* [Backend: TF-IDF](https://github.com/NatLibFi/Annif/wiki/Backend%3A-TF-IDF)
* [Project configuration](https://github.com/NatLibFi/Annif/wiki/Project-configuration)

---

<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
