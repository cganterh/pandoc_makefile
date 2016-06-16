sources = $(wildcard *.md)
targets = $(sources:.md=.pdf)

.PHONY: all
all: $(targets)

ifeq ($(wildcard template.tex),template.tex)
%.pdf: %.md template.tex
	pandoc $< -o $@ --latex-engine=xelatex --template=template.tex
else
%.pdf: %.md
	pandoc $< -o $@ --latex-engine=xelatex
endif

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
