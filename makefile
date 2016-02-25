sources = $(wildcard *.md)
targets = $(sources:.md=.pdf)

all: $(targets)

.PHONY: view all standard

%.pdf: %.md
	pandoc $< -o $@ --latex-engine=xelatex

.standard: $(sources)
	for FILE in $?; \
	do \
	    cp $$FILE $$FILE~; \
	    pandoc $$FILE -o $$FILE --columns=60 -s; \
	done
	touch $@

standard: .standard

view: $(targets)
	xdg-open $^

clean:
	rm -f .standard $(targets)
