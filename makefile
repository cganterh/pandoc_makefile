sources = $(wildcard *.md)
targets = $(sources:.md=.pdf)

.PHONY: all
all: $(targets)

%.pdf: %.md
	pandoc $< -o $@ --latex-engine=xelatex

.standard: $(sources)
	for FILE in $?; \
	do \
	    cp $$FILE $$FILE~; \
	    pandoc $$FILE -o $$FILE --columns=60 -s; \
	done
	touch $@

.PHONY: standard
standard: .standard

.PHONY: view
view: $(targets)
	for FILE in $^; \
	do \
		xdg-open $$FILE; \
	done

clean:
	rm -f .standard $(targets)
