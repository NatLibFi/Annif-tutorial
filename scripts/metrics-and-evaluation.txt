Welcome to this Annif tutorial video.
In this video we discuss how to systematically test and compare Annif models 

To have an understanding of how well Annif models work, we could just use Annif to get subject suggestions for a document and then manually inspect and grade the results. But doing that for many documents is tedious or completely unfeasible. 

A better approach for evaluating Annif models is to use subjects assigned by a human as a gold standard to which the subjects suggested by Annif are automatically compared. This can easily be done for thousands of documents.

The quantity, that is used to measure the match between the subjects suggested by Annif and those given by a human, is called metric.

Metrics provide numerical values that allow easy comparisons of the performance of Annif models. There exist many different metrics developed for machine learning and information retrieval, and each of them emphasizes a slightly different view of the match. In this tutorial we consider precision, recall, F1 score, and NDCG. 

All these metrics can have values between 0 and 1.

Let’s first take a look at the precision. The precision is the fraction of the correct subjects among the subjects suggested. It answers the question: “How many of the suggested subjects are actually correct?”

Then, the recall is the fraction of all correct subjects that were actually suggested. Recall answers “How many of those subjects that should be suggested have actually been suggested?”

Depending on the task, either precision or recall can be more important than the other, but generally one would like to have some balance between them. F1 score helps in this, as it is the harmonic mean between the two, and so by finding a high F1 score, then both precision and recall are at least pretty high.

The NDCG stands for Normalized Discounted Cumulative Gain. The NDCG is a ranking-based measure, that is, the order of the subjects suggested is taken into account. Simply put: Getting the top ranked result right will matter more than getting the 2nd or 3rd right.

Now, before moving to how the evaluation is performed with Annif, an important point about training and evaluating models needs to be mentioned.

In the training of a machine-learning model the aim is to make the predictions the model makes on input to fit the desired output. In the case of Annif the input is text and the output are subjects of the text. The fit to the training data can become very close, and so if model evaluation is run using the same data, very good metric values can be obtained. However, this does not correspond to a real use case of the model. In real use the model needs to make predictions on some new, unseen input, in which case the predictions can be much worse.

So, the evaluation should always be performed using data that the model has not seen before at training time. For this reason a part of all the data at hand should be kept separated as a test set, which is used only for the evaluation. 

The data can also be split into three parts, as has been done for the full-text documents of this tutorial, the third set is then called a validation set. The validation set is used when one wants to optimize the hyperparameters of a model. That process is the following: a model is fit to the training data, and evaluated using the validation data. These fitting and evaluation steps are repeated with varied hyperparameter values, and in the end the values that give the best evaluation results are chosen for the final model. In this process the model gets to know both the training and validation data, so the final evaluation is performed using the test set data that the model has not seen at all. 

There are many details in the evaluation and metrics that can not be covered here. Luckily, in practice calculating the metrics for Annif suggestions is easy: there is one command for that.

The eval command takes the ID of a project to be evaluated as the first argument, and a path to the documents to use for evaluation as the second argument. It outputs a report with several metrics. 

Because subject-indexing is a multi-label classification problem, there are many alternatives on how to compute the metrics in detail. This is why the report includes precision, recall, and F1 score obtained with different averaging perspectivesways. Generally, maybe the most useful metrics are the document-averaged metrics, for which the metric values are first calculated for each document and then the final values are obtained by averaging over the values of all documents. 

There are also entries like F1@5, which means that this F1 score has been calculated by retaining only the five highest ranked suggestions of each document. 


Lets see the evaluation in practice.

The YSO-TFIDF project has been trained earlier and now I evaluate it. So, the command starts as
annif eval yso-tfidf-en
and then comes the path to the human-indexed documents:
data-sets/yso-nlf/docs/test/

Note that I use the “test” subdirectory of the “docs” directory, which contains the documents to be used only for evaluation.

I start the evaluation and it takes around 5 minutes to complete.

Once the evaluation is finished, the report is printed out, and it can be saved for the future.
 
This video introduced the metrics and evaluation principles used in subject indexing with Annif.
Thank you for watching!
