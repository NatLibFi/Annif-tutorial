# Exercise 9: Hogwarts Sorting Hat using fastText

In this lesson, we will use Annif and fastText to implement a [Sorting
Hat](https://harrypotter.fandom.com/wiki/Sorting_Hat), which can determine
which House (Slytherin, Ravenclaw, Hufflepuff or Gryffindor) a first-year
student at the Hogwarts school should join.

[fastText](https://fasttext.cc/) is a machine learning model for text
classification developed by Facebook Research. It has some advanced
features, such as being able to use word and character level n-grams (i.e.
words that appear together and subwords) and to create word embeddings. On
the downside, it has lots of tunable parameters and finding a combination
that works well on a given data set can be a challenge.

Note that if you have a local installation of Annif, you will first need to install the 
[optional fastText dependencies](https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies#fasttext-backend).

The original Sorting Hat reads the thoughts of the student, but Annif
generally does not have access to that kind of information, so we will
simply use the name of the student as input. We will train a fastText model
on the names of characters from the Harry Potter novels whose house is
known. To make it possible to generalize the model to new, unseen names, we
will use *character n-grams* to split all names into chunks of 1 to 4
characters - for example `harry` becomes [`h`, `ha`, `har`, `harr`, `a`,
`ar`, `arr`, `arry` ...]. fastText can do this when given the `minn` and
`maxn` parameters, which set the minimum and maximum length of character
n-grams to generate from input text.

## 1. Define a fastText project in the `projects.cfg` file

Use a text editor to add a new project definition to the end of the
`projects.cfg` file.

    [hogwarts]
    name=Hogwarts Houses
    language=en
    analyzer=simple
    backend=fasttext
    vocab=hogwarts
    limit=4
    dim=100
    lr=0.25
    epoch=100
    loss=softmax
    chunksize=1000
    minn=1
    maxn=4
    minCount=3

The parameters are set in such a way that the model should heavily overfit
on the small data set it will be trained on - in particular, the number of
epochs is very high. Usually overfitting is bad, but in this case, we want
the model to accurately remember all the examples it is trained on and it
doesn't matter if it overfits, as long as it provides interesting results on
unseen names.

## 2. Load the vocabulary of Hogwarts houses

Run this command:

    annif loadvoc hogwarts data-sets/hogwarts/hogwarts-vocab.tsv

The vocabulary file is really small and simple, it just contains a line for
each of the four Hogwarts houses along with their Wikidata URIs.

## 3. Train the project using known characters

Run this command:

    annif train hogwarts data-sets/hogwarts/hogwarts-train.tsv

## 4. Verify that the model works correctly

Normally it is bad practice to evaluate a model on the same data it was
trained on, but in this case we can use the original training data to verify
that the model correctly remembers the houses of all the Harry Potter
characters it was trained on. We can evaluate on the same file:

    annif eval hogwarts data-sets/hogwarts/hogwarts-train.tsv

Check the *Precision@1* score. It should be 1.0, indicating that all known
Harry Potter characters are correctly classified. If not, increase the
number of epochs in `projects.cfg`, retrain and revalidate.

## 5. Test the model on new names

Now the interesting part - which house is for you? Test it like this:

    echo "Your Name" | annif suggest hogwarts

The first entry is your house.

You can also try the Web UI with this project.

Note: Although this exercise is a bit silly, it demonstrates a useful
technique.  Character n-grams can be used to perform approximate matching
and/or matching of subwords (e.g.  parts of compound words), making it
possible to generalize the model beyond words it was trained on. They can
also be used to identify the language a text is written in, because
different languages have different frequencies of characters and short
character sequences.


Congratulations, you've completed Exercise 9! You now know which Hogwarts
House you belong to and know how to use character n-grams in fastText.
