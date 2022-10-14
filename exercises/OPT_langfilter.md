# Optional exercise: Languages and filtering
Sometimes it is useful to further preprcess the text before passing it on to Annif. Sometimes the text might contain two or more languages, especially academic texts.
In this case, it might be usseful to filter out anything but the main language of the document. 

The language detection is performed with [Compact Language Detector v3](https://github.com/google/cld3) via [`pycld3`](https://pypi.org/project/pycld3/). `pycld3` is an optional dependency of Annif, see the [installation page](https://github.com/NatLibFi/Annif/wiki/Optional-features-and-dependencies#language-filtering-with-pycld3). Detection and filtering is performed sentence-by-sentence. Because language detection for short sentences is unreliable, all sentences shorter than the `sentence_min_length` parameter value (in characters, by default 50) bypass the filtering. Also, if the whole text is shorter than `text_min_length` (by default 500) it bypasses the language filtering as one. 

When `filter_lang` is combined with the `limit` transform, for performance reasons it can be useful to apply an initial limit transform to avoid passing unnecessary amount of text to the language detection, for example with a transform setting like `transform=limit(15000),filter_lang,limit(5000)`.

There is also the possibility to shorten long texts. ## `limit` transform truncates an input document to a given length. It takes the number of characters to retain as parameter. 

This transform can be advantageous in case of long documents that have an abstract and/or introduction as it enables the backend to consider only those representative parts of the text. For example for [JYU theses](https://github.com/NatLibFi/Annif-corpora/tree/master/fulltext/jyu-theses) a good value for limit is 5000.



---
<p align="center">
|
<a href="/exercises/README.md">Back to table of contents »</a>
</p>
