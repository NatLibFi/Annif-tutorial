Welcome to this Annif tutorial video. In this video we give a short description of the two data sets you can choose from in order to complete the exercises of this tutorial.

On the one hand there is the data set of the National Library of Finland which contains the trilingual General Finnish Ontology YSO plus the additional vocabulary YSO-Places for geographic terms, then a training data set constructed from metadata records from the Finna dot fi discovery service, and over 2000 English language Master's and doctoral theses published from 2010 to 2017 from the University of Jyväskylä.

On the other hand there is the data set of the Leibniz Information Centre for Economics, or ZBW, which contains their own standard thesaurus for economics, or STW, then a training data set constructed from metadata records from the EconBiz discovery service, and over 4000 working papers in economics from the ZBW open access repository EconStor.

Furthermore, the given sets are divided into training data based on metadata, which is provided in a TSV format where the first column contains the title of the resource and the following columns each contain the ID of a descriptor that has been assigned to this resource intellectually,

and into training data based on fulltexts which is provided as pairs of URLs pointing to the PDF and TSV files listing the IDs of the descriptors that have been assigned to this text intellectually.

And here is a summary of both data sets where one is based on a larger, trilingual und universal vocabulary and the other on a more concise, bilingual vocabulary for the domain of economics.
We have also provided small subsets of around 100.000 entries of the short text training sets for quick tests, and we have divided the fulltext corpus into suitable subsets for training, validating and testing the methods that we will look at in the following exercises, respectively.

We suggest that you pick one of the data sets and stick to it for the rest of this tutorial
in order to be able to compare the results for various methods.

---

So, how do you get the data sets? Two steps are necessary.

The first step is to download the data sets from the Annif-tutorial GitHub repository. If you are using the VirtualBox image, you can skip this step, since the image already includes them. If you’re using a Docker or Linux installation, you can either download the repository as a zip file from GitHub, or use Git tools to clone the repository. Either way, you should end up with a folder called Annif-tutorial, containing the data sets.

The second step is to download the fulltext files and convert them to text files. Due to copyright reasons, we cannot redistribute the fulltext documents, so they must be downloaded from JYX or EconStor, and the PDF files must be converted to text so that Annif can process them. This is all automated, using a Makefile, but it takes about half an hour or more, depending on the speed of your Internet connection, to run it. Here you can see the commands that you need to run, depending on which data set you’ve chosen.

Now I will demonstrate how to download and convert the stw-zbw data set. I’m using the VirtualBox image, but the process is similar for other types of installation.

I will open a terminal window and make sure that I’m in the Annif-tutorial directory.

Then I will go to the directory where the fulltext documents are:

cd data-sets/stw-zbw/docs/

cd And I will run the Make command:

make -j4 -k

(here, the number 4 means that there will be four processes running in parallel, which speeds this up a little bit)

This will take about half an hour, so I will skip to the end. There may be some warnings from the PDF conversion for example about font issues, but these can be safely ignored.

Now the download and conversion is complete. I can go back to the tutorial directory

cd -

You have now been introduced to the data sets of this tutorial and how to get them to your own computer. You can now start completing the tutorial exercises. Thank you for watching!
