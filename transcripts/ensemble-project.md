Welcome to this Annif tutorial video. In the following we will learn about ensembles.

When evaluating algorithms for automated subject indexing, you may notice that they make some silly mistakes.
This may be due to several reasons:
It could be simply errors in your training data
Or you have a lot of documents in one area, for example computer science but little on music. This is called skew and may lead the algorithm to prefer concepts that are related to computer science.
It could also be the case that a concept is often assigned when there is a specific set of words present in the input. However this assignment may not always be correct.
You also have to consider homonyms. Rock could either be a stone or a style of music.
The same goes for names, where smith could also be profession
Finally random noise may impact the predictions

Let’s make an analogy. Consider these three musicians. The first one has a broken instrument, the second misses a beat and the last one plays out of tune. Therefore, their individual performances may not be very enjoyable.

By having them play at the same time and under the supervision of a conductor, their playing will improve and the flaws may be less obvious.

This can be transferred to automated subject indexing.
As in music combining multiple algorithms is called an ensemble.
The goal is to combine the strength of the individual algorithms while reducing their weaknesses.

There are three ensemble backends available in Annif
The first one symply averages the scores of the individual algorithms
Then there is the PAV ensemble. It applies isotonic regression to estimate the relationship between the individual scores and the actual subjects. It requires training with annotated documents.
Finally there is the neural network ensemble. It starts like the simple averaging ensemble but adjusts the score based on data. It can also be trained incrementally. This means, if you obtain additional data in the future, you may be able to further improve the results.

Let’s have a look on how we can configure a simple ensemble project.
Open you project configuration file:
> nano projects.cfg
This file has a tfidf project and a maui one.
Let’s add the ensemble
[stw-ensemble-en]
Again we need to specify the name
name=STW ensemble project
The language
language=en
The vocabulary
vocab=stw-en
And set the backend to ensemble
backend=ensemble
Now we need to specify the backends the ensemble consists of.
This is done using the sources key
sources=stw-tfidf-en,stw-maui-en
This will give equal weight to both backends.
By adding
:2
We will give double the weight to the maui backend
Exit and save the document

Now we will see what an ensemble can do for us.
Start by typing
> echo “History of Salt Prices in Germany”
This is a made up title for this example.
We pipe (|) this to
annif suggest stw-tfidif-en

When we look at the results, we see that salt is in the first place, which is good.
But in second place is “Mongolians”. Which can not be extracted from the title.
This may be due to documents in our training corpus that relate salt to mongolians.
Instead, one would expect “Germany” as it is the region referenced in the title.
The price related subjects further down the list are mostly correct.
Let’s see the results of maui.
By pressing the up-arrow-key we retrieve the command from the history
Press the left-arrow-key to edit the command and replace tfidf with maui and hit enter

Maui is able to extract all relevant words from the title.
Now see what the ensemble returns.
By pressing the up arrow, retrieve the command and change maui to ensemble.
Now we get “Germany in the second place”.
“Mongolians” is still in third place” but with a much lower score.
By cutting off the suggestions as 0.15 You would get acceptable results.

Now you have seen how you can use ensembles to improve your results. Thank you for watching!
