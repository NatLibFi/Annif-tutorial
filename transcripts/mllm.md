Welcome to this Annif tutorial video. 

In this video, we will set up, train and evaluate a project using the MLLM algorithm. It is an algorithm for lexical automated subject indexing, which works by matching terms in document text to terms in a controlled vocabulary. MLLM is inspired by Maui, an older lexical automated subject indexing tool, but it is implemented in Python within Annif.

First, we need to edit the projects.cfg file by adding the MLLM project. On the left, you can see an example configuration for the yso-nlf data set. On the right, there is a similar configuration for the stw-zbw data set.

Next, we train MLLM with some fulltext documents. MLLM requires a relatively small amount of training data. The training should be done with similar documents to those we will use in testing. You can run the training using the annif train command. We’ll use the docs-limit option to select 400 fulltext documents from the train subset. We won’t be using the full train set, because it would take a lot longer to train with the full set and the results wouldn’t be that much better.

The next step is to test the project on example documents. When you’ve confirmed that the project gives reasonable suggestions, you can evaluate it on a larger corpus.

Let’s see these steps in practice.

--

I’m using Annif within VirtualBox, but the steps are the same in every type of installation. I will first open a web browser, go the exercises of the tutorial, and the MLLM exercise page. I copy the project configuration either for the NLF or ZBW dataset to the clipboard. Here I choose the ZBW dataset. Then I open the text editor, open the projects.cfg configuration file that was created earlier, paste the MLLM configuration, and save the file. 

Next, I open a terminal window. I can now check that the MLLM project appears in the output of the annif list-projects command. -- It’s there. The vocabulary was already loaded when setting up the TFIDF project, so I won’t have to do it again.

Now I can train the project using fulltext documents from the train set. Let’s again open the exercise page and copy the train command 
annif train stw-mllm-en data-sets/stw-zbw/docs/validate

Training should take a few minutes. -- Now it’s done.
Let’s test the project with an example sentence. Again I’m opening the exercise page, and I select and copy the example command:

echo "frequently occurring or otherwise salient terms in the document are matched with terms in the vocabulary" | annif suggest stw-mllm-en

We got only a couple of suggestions, much less than for the TFIDF model. This is because the lexical algorithm only considers subjects that are explicitly mentioned in the text. In this short sentence, only these subjects could be found.

Now let’s test the algorithm on a longer document. We will use the same document that was used to test the TFIDF project. Again I open the exercise page and copy the command:

annif suggest stw-mllm-en <data-sets/stw-zbw/docs/test/10008797547.txt

This time there were a lot more suggestions because it is a long document, so there are many more opportunities for matching subjects from the vocabulary.



Finally, let’s evaluate the MLLM project on a test collection of documents. Once more I open the exercise page and copy the command:

annif eval stw-mllm-en data-sets/stw-zbw/docs/test/

Evaluation should take around 3-4 minutes for the ZBW data set and around 10 minutes for the NLF data set.

Now it’s complete. We can note the F1@5 and NDCG scores and compare them to the scores of the TFIDF project. The scores should be much better for both data sets!

Note that there is also an EXTRA section in the MLLM exercise. This section explains how to create a learning curve, which can be used to investigate how many training documents would be needed in order to get the best possible results. If you have the time, you can follow along the instructions to create your own learning curve. The same can be done for any type of Annif project, not just for MLLM.

Now we have finished setting up, training and evaluating an MLLM project. Thank you for watching!

