# Subject Inclusion and Exclusion 

Annif lets you control which subjects a project can suggest by filtering the vocabulary using the `vocab=` parameter in `projects.cfg` (INI format) or `projects.toml` (TOML format). This is useful when you want a project that focuses on a specific part of a thesaurus — for example, only geographic terms, only high-frequency descriptors, or everything *except* a handful of unwanted labels.

This exercise uses the STW Thesaurus for Economics as the example vocabulary.

> **Note:** Subject inclusion and exclusion filters were introduced in Annif 1.4. Make sure you are running at least that version.

---

## How subject filters work

Subject filters are appended to the vocabulary identifier using parentheses:

```
vocab = "stw(filter1=value1,filter2=value2)"
```

The available filter keywords are:

| Filter keyword | Description |
|---|---|
| `include=<URI>\|<URI>…` | Include only the listed concept URIs (pipe-separated) |
| `exclude=<URI>\|<URI>…` | Exclude the listed concept URIs (pipe-separated) |
| `include=*` | Include all concepts (useful combined with `exclude_type=` etc.) |
| `exclude=*` | Exclude all concepts (useful before adding back with `include_type=` etc.) |
| `include_type=<URI>` | Include all concepts of a given RDF type |
| `exclude_type=<URI>` | Exclude all concepts of a given RDF type |
| `include_collection=<URI>` | Include all concepts belonging to a SKOS collection |
| `exclude_collection=<URI>` | Exclude all concepts belonging to a SKOS collection |
| `include_scheme=<URI>` | Include all concepts belonging to a SKOS concept scheme |
| `exclude_scheme=<URI>` | Exclude all concepts belonging to a SKOS concept scheme |

URI values can be given as full URIs or as CURIEs (shortened URIs). CURIEs use the prefix definitions from the vocabulary's own SKOS file. For example, `zbwext:Thsys` is the CURIE for `http://zbw.eu/namespaces/zbw-extensions/Thsys`.

Rules are applied **in the order they are specified**. The starting point is always: no concepts excluded.

---

## Example 1: Exclude all Thsys nodes from the descriptor list

**Scenario:** The STW thesaurus contains two types of concepts: `Descriptor` (the actual subject terms used for indexing) and `Thsys` (hierarchical structure nodes used to organise the thesaurus). Thsys nodes like *B.01 General Economics* are not meant to be assigned as descriptors. You can exclude them by type.

In `projects.toml`:

```toml
[stw-tfidf-no-thsys]
name = "TF-IDF STW without Thsys nodes"
language = "en"
backend = "tfidf"
vocab = "stw(exclude_type=zbwext:Thsys)"
analyzer = "snowball(english, token_min_length=2)"
```

> **What this does:** All concepts in STW are included by default. Any concept whose RDF type is `http://zbw.eu/namespaces/zbw-extensions/Thsys` is then excluded. The model trains and suggests on the remaining `Descriptor` concepts only.

You can also use the full URI instead of the CURIE:

```toml
vocab = "stw(exclude_type=http://zbw.eu/namespaces/zbw-extensions/Thsys)"
```

To train the project:

```bash
annif train stw-tfidf-no-thsys data-sets/stw-zbw/docs/train/
```

---

## Example 2: Exclude specific high-frequency "head" labels

**Scenario:** Very frequent, generic labels like *Theory* (`http://zbw.eu/stw/descriptor/19073-6`) and *United States* (`http://zbw.eu/stw/descriptor/14415-5`) appear in many documents and can dominate suggestions, pushing out more specific and informative terms. You can train a project that explicitly excludes these labels.

In `projects.toml`:

```toml
[stw-tfidf]
name = "TF-IDF model (head labels excluded)"
language = "en"
backend = "tfidf"
vocab = "stw(exclude=http://zbw.eu/stw/descriptor/19073-6|http://zbw.eu/stw/descriptor/14415-5)"
analyzer = "snowball(english, token_min_length=2)"
```

> **What this does:** All STW descriptors are included by default. The two listed URIs are then excluded. Pipe (`|`) separates multiple URIs. You can extend this list with as many descriptors as needed.

To compare how suggestions differ from a full-vocabulary baseline:

```bash
echo "The economic policy debate in the United States" | annif suggest stw-tfidf-tail
echo "The economic policy debate in the United States" | annif suggest stw-tfidf-en
```

---

## Example 3: Include only geographic terms (YSO places scheme)

**Scenario:** You want a dedicated geographic indexing project that *only* suggests place-name descriptors. In YSO, geographic terms live in a separate concept scheme called YSO places (`http://www.yso.fi/onto/yso/places`), so the right filter is `include_scheme=` rather than `include_collection=`.

In `projects.toml`:

```toml
[yso-tfidf-geo]
name = "YSO geographic terms only"
language = "en"
backend = "tfidf"
vocab = "yso(exclude=*,include_scheme=http://www.yso.fi/onto/yso/places)"
analyzer = "snowball(english, token_min_length=2)"
```

> **What this does:** All concepts are excluded first (`exclude=*`), then only concepts belonging to the YSO places concept scheme are added back. The model will only ever suggest geographic place names like *Finland*, *Southeast Asia*, or *Baltic States*.

---

## Quick reference: filter syntax

```
# Exclude all concepts of a given RDF type (e.g. Thsys nodes)
vocab = "stw(exclude_type=zbwext:Thsys)"

# Denylist: exclude specific concepts by URI
vocab = "stw(exclude=<URI1>|<URI2>)"

# Allowlist: exclude everything, add back specific concepts
vocab = "stw(exclude=*,include=<URI1>|<URI2>)"

# Include only concepts from a SKOS collection
vocab = "stw(exclude=*,include_collection=<collection-URI>)"
```

---

Congratulations! You now know how to use subject inclusion and exclusion filters to scope Annif projects to specific parts of the STW Thesaurus. For the full filter reference, see the [Annif wiki: Subject exclusion and inclusion](https://github.com/NatLibFi/Annif/wiki/Subject-exclusion-and-inclusion).
