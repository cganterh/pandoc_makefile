sources = $(wildcard *.md)
targets = $(sources:.md=.pdf)

all: $(targets)

.PHONY: view all

%.pdf: %.md
	pandoc $< -o $@ --latex-engine=xelatex

standard: $(sources)
	for FILE in $?; \
	do \
	    cp $$FILE $$FILE~; \
	    pandoc $$FILE -o $$FILE --columns=60 -s; \
	done
	touch $@

view: $(targets)
	evince $^

clean:
	rm -f standard $(targets)
