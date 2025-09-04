# Optional exercise: Annif REST API

In this exercise, we will look at the basics of the REST API. Some
familiarity with REST-style API services and JSON data is expected.

Annif provides a simple REST API which can be used to integrate other
systems with Annif. The main function of Annif, automated subject indexing,
can be used by the `suggest` and `suggest-batch` methods.
There are also other methods, see below.

## Annif REST API Methods
### API Information
- **GET /v1/**: Get basic information about the API service.
### Vocabulary Information
- **GET /v1/vocabs**: Retrieve a list of available vocabularies.
### Project Administration
- **GET /v1/projects**: List all projects.
- **GET /v1/projects/{project_id}**: Get details of a specific project.
### Automatic Subject Indexing
- **POST /v1/projects/{project_id}/suggest**: Suggest subjects for a single input text.
- **POST /v1/projects/{project_id}/suggest-batch**: Suggest subjects for a batch of up to 32 documents.
### Learning from Feedback
- **POST /v1/projects/{project_id}/learn**: Submit manually indexed documents for incremental/online learning (see the [extra section of the NN ensemble exercise](https://github.com/NatLibFi/Annif-tutorial/blob/main/exercises/OPT_nn_ensemble_project.md#extra-incremental-learning)).
### Language Detection
- **POST /v1/detect-language**: Detect the language of a given text from a list of candidate languages (see the [Languages and filtering exercise](exercises/OPT_langfilter.md)).

--- 

Swagger UI of the Annif instance of the website [annif.org](https://annif.org) can be accessed at https://api.annif.org/v1/ui/.

## 1. Start up Annif as a web server

Run the command:

    annif run --host 0.0.0.0

Annif will start up and keep running until you stop it (by pressing Ctrl-C).

## 2. Open the Swagger UI in the browser

The Annif REST API is defined using an OpenAPI/Swagger specification. An
interactive Swagger UI viewer is integrated, allowing the REST API methods
to be displayed and tested in a web browser.

Use your browser to access the URL
[http://127.0.0.1:5000/v1/ui/](http://127.0.0.1:5000/v1/ui/)

In case of connection problems and you are using Docker, try using
[http://192.168.99.100:5000/v1/ui/](http://192.168.99.100:5000/v1/ui/) instead of
`127.0.0.1`. 

You should see a Swagger UI user interface with a green bar on top and a
list of method categories in the middle.

## 3. List the projects and vocabularies

Under the category *Project administration*, click on the `projects/`
method name, the *Try it out* button, and finally the *Execute* button. You should see a JSON
response detailing all the projects defined in `projects.cfg` in the
*Response Body* section. The other sections show the actual URL that was
called, the HTTP headers received and a recipe for using `curl` to access
the method from the CLI.

Copy the `curl` recipe to a terminal window and press Enter. You should see
the same JSON response body.

Similarly, using the `vocabs` method under the category *Vocabulary information*
you can get a list of all the vocabularies that defined in the `projects.cfg`
including information about the languages they support etc.

## 4. Test automated subject indexing

Close the category *Project administration* if it is still open, and open
the last category *Automatic subject indexing*. Click on the
`projects/{project_id}/suggest` method name. Scroll down and fill in the
form fields, at least `project_id` (use one of the projects you've set up)
and `text` (any example text you can think of). Then press the *Try it out*
button. Again, you should see the response body with subject suggestions for
the text you entered, the HTTP response headers and the `curl` recipe.

Copy the `curl` recipe to a terminal window and press Enter. You should see
the same JSON response body.

Congratulations, you've completed Exercise 7!  You now know what kind of
methods and services the Annif REST API provides and how to access them from
a web browser and the `curl` command line tool.

## Sending text file
The `curl` tool can also send the contents of a text file to Annif API for suggestions. 
For this you need to replace the option `-d 'text=your_example_text&limit=10'` 
with `--data-urlencode 'text@your_example_file.txt'`.

## Annif-client 
[Annif-client](https://github.com/NatLibFi/Annif-client) is a minimal Python 3.x 
client library for accessing the Annif REST API. 
[This Jupyter notebook](https://colab.research.google.com/drive/1S0JX_befWeECKCJEZYSvcGzCnJfDePF0?usp=sharing) 
includes some examples of the use of Annif-client; getting suggestions for news texts 
fetched via news agency APIs and for texts OCRed from a photo by a webcam.

---

<p align="center">
|
<a href="/README.md">Back to the main page »</a>
</p>
