Welcome to this Annif tutorial video. In this video, we will set up and train a simple Annif project, which uses a TFIDF model.

Since this is our first Annif project, let’s give a brief introduction to Annif projects.
A project is used to tell Annif which kind of algorithm, vocabulary, language and other settings to use. 

Projects are defined in a file usually called projects.cfg - or projects.toml - and located in the current directory where Annif is executed. This default file name and location can be overridden using an environment variable or a command line option if necessary.

A project is identified by a project id, which is typically a short string. 
Annif also has a list-projects command to show the configured project..


In this exercise, we will create a TFIDF project, which is the simplest type of project in Annif. It’s like the “Hello, World” of automated subject indexing algorithms: it’s quick to set up, train and test. You get to see results quickly, but it’s not the final say when it comes to quality.


Now lets see how to define a TFIDF project in the projects.cfg file. On the left there is a configuration suitable for the dataset of the National Library of Finland, and on the right for the dataset of ZBW.

On both configurations the project identifier is at the first line in square brackets. In the following lines are the name and language of the project. The backend entry defines the algorithm to use, and vocab is an identifier for the vocabulary. These settings are mandatory for all Annif backends.

The TFIDF algorithm, like most backends, also needs the analyzer setting. The analyzer takes care of the preprocessing, tokenization, and normalization of the input text. We will use the Snowball analyzer for English here, as it helps to normalize unimportant distinctions such as singular vs. plural forms.

The projects.toml file looks the same but requires all string variables to be quoted. In this video we will use the previously mentioned projects.cfg file.

Here are the steps for setting up a new TFIDF project.

The first step is to add the project configuration to a file, here projects.cfg.

The second step is to load the vocabulary, which is done using the annif load-voacab command. The vocabulary can be in a TSV file, that is in a simple tab-separated-values format, or in a SKOS/RDF file. 

The third step is training the project. The command is annif train, which takes the project ID as the first argument, and a path to the training data as the second argument. The training data or training documents can be collected to one TSV file, which can be compressed, or to a directory containing several documents. More information on the formats can be found from the Annif wiki pages. Note that the training step can take a long time, up to several hours in some cases.

After training the project is ready to be used. First, we can use just a short sample text and give it to the annif suggest command. The suggest command expects the text from standard input, so the echo command can be used for writing the text and the pipe character then to pass the text to Annif suggest. 

For testing with a longer text it is better to have the text in a file, whose contents can then be fed to the suggest command with this kind of command. 

Let’s see these steps in practice.

I’m using Annif within VirtualBox, but the steps are the same in every type of installation. I will first open a web browser, go the exercises of the tutorial, and the TFIDF exercise page. I copy the project configuration either for the NLF or ZBW dataset to clipboard. Here I choose the ZBW dataset. Then I open the text editor, paste the configuration, and save the file to the Annif tutorial directory with the name projects.cfg. 

Next, I open a terminal window. I make sure with that the projects.cfg file is here in the Annif tutorial directory using the command ls

I can now check that the TFIDF project appears in the project listing shown by the command annif list-projects.

The project is here on the list, so the configuration was successful.

Next, I will load the vocabulary for the project using the loadvoc command.  I can go the exercise page again and copy the exact command and paste it to the terminal (you can use Shift-Ctrl-V to paste to the terminal window).

annif loadvoc stw-tfidf-en data-sets/stw-zbw/stw-skos.ttl

This shouldn’t take more than a minute or so. Now it’s finished

Now I can train the project. In the training I will use training data that contain titles and subjects extracted from around a million metadata records. However, I will first try with just a small training file based on 100,000 records to test the process. Let’s copy the command again

annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz-small.tsv.gz

Training should take around a minute.

Now the training is finished, and we can test the project! I copy and paste an example sentence and the command from the exercise page of the tutorial, the essential part is the annif suggest followed by the project ID:

echo "Machine learning algorithms build a mathematical model based on sample data" | annif suggest stw-tfidf-en

We can see that Annif produced some suggestions, which were at least somewhat relevant.

Now we saw that the basic model works, but the amount of training data was small. Much better results are obtained when the project is retrained using a complete training data set:
annif train stw-tfidf-en data-sets/stw-zbw/stw-econbiz.tsv.gz
This should take around 5 minutes for the ZBW data set and around 10 minutes for the NLF data set.
The model is now trained with the full training data set. Instead of testing the model with just one sentence, I will now get suggestions for a longer document from a file. I will use a sample file from the full-text documents.

I will ask Annif for subject suggestions to the first test document that is in the ZBW data-set:
annif suggest stw-tfidf-en <data-sets/stw-zbw/docs/test/10008797547.txt

We will see how to explore the Annif results in more depth in some of the following exercises.

You have now seen how to create and use a simple TFIDF project. Thank you for watching.
