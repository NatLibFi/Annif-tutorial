# Rules for fetching and converting documents

all: pdf txt

pdf: $(patsubst %.url,%.pdf,$(wildcard */*.url))

%.pdf: %.url
	wget -q --tries=5 --no-use-server-timestamps -O $@ -i $< || rm -f $@ $<

txt: $(patsubst %.url,%.txt,$(wildcard */*.url))

%.txt: %.pdf
	pdftotext $< || true

.PHONY: all pdf txt
