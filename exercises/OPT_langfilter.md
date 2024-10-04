# Optional exercise: Languages and filtering
## Language detection
Annif itself is language independent, save for the language support offered by the tools it employs, 
but the Annif projects are typically language specific.
Thus, a text of a given language needs to be processed with a project intended for that language. 

Annif includes a language detection feature that helps to determine the appropriate language-specific
project to use for processing a given text (either for train, evaluation or suggestion operation),
which might otherwise need to be manually performed if the documents can be of different languages.

The language detection is performed with the [Simplemma](https://github.com/adbar/simplemma) library.

### CLI command
For detecting the language using the CLI there is the `detect-language` command.
It expects the candidate language codes as a comma-separated argument, and the text to analyze via standard input or as a file.

Run the following commands to use `echo` command to provide texts via standard input:
    
    echo "This is a sample text to detect language." | annif detect-language en,fi,de
    echo "Tämä on esimerkki tekstiä kielen tunnistamiseen." | annif detect-language en,fi,de
    echo "Dies ist ein Beispieltext zur Spracherkennung." | annif detect-language en,fi,de
    echo "Varklithen zopfma durith zinglot brestive fawrik." | annif detect-language en,fi,de

Observe the output. Which language has the highest probability for each line?
### REST API method
If you have Annif instance running at localhost, you can use its `/v1/detect-language` endpoint with `curl` like this:

    curl -X 'POST' \
      'http://localhost:5000/v1/detect-language' \
          -H 'accept: application/json' \
          -H 'Content-Type: application/json' \
          -d '{
              "text": "This is a sample text to detect language.",
              "languages": [
                "en", "fi", "de"
              ]
            }'

## Input text transforms
Sometimes it is useful to further preprocess the text before passing it on to Annif.

### Language filtering
A text might contain two or more languages, for example the abstracts of academic dissertations.
In this case, it might be useful to filter out anything but the main language of the document, which can be done using the [`filter_lang` transform](https://github.com/NatLibFi/Annif/wiki/Transforms#filter_lang-transform).

Language detection and filtering is performed sentence-by-sentence. Because language detection for short sentences is unreliable, all sentences shorter than the `sentence_min_length` parameter value (in characters, by default 50) bypass the filtering. Also, if the whole text is shorter than `text_min_length` (by default 500) it bypasses the language filtering as one. 

### Lenght limiting
There is also the possibility to shorten long texts. The [`limit` transform](https://github.com/NatLibFi/Annif/wiki/Transforms#limit-transform) truncates an input document to a given length. It takes the number of characters to retain as parameter. 

This transform can be advantageous in case of long documents that have an abstract and/or introduction as it enables the backend to consider only those representative parts of the text. For example for [JYU theses](https://github.com/NatLibFi/Annif-corpora/tree/master/fulltext/jyu-theses) a good value for limit is 5000.

When `filter_lang` is combined with the `limit` transform, for performance reasons it can be useful to apply an initial limit transform to avoid passing unnecessary amount of text to the language detection, for example with a transform setting like `transform=limit(15000),filter_lang,limit(5000)`.

## Analyzers
The analyzers Annif uses to pre-process, tokenize and normalize text are usually language dependendent.
You can try different analyzers for the tfidf project by making chances in the `projects.cfg` file:

If you use the `yso-nlf` data set, use the following contents:

    [yso-tfidf-en-2]
    name=YSO TFIDF project
    language=en
    backend=tfidf
    vocab=yso
    analyzer=simplemma(en)

If you use the `stw-zbw` data set, use the following contents:

    [stw-tfidf-en-2]
    name=STW TFIDF project
    language=en
    backend=tfidf
    vocab=stw
    analyzer=simplemma(en)
    
Did the result change?

## More information

For more information, see the documentation in the Annif wiki:

* [Language detection](https://github.com/NatLibFi/Annif/wiki/Language-detection)
* [Analyzers](https://github.com/NatLibFi/Annif/wiki/Analyzers)
* [Transforms](https://github.com/NatLibFi/Annif/wiki/Transforms)

---
<p align="center">
|
<a href="/README.md">Back to the main page »</a>
</p>
