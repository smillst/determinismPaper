.PHONY: paper.pdf all clean

all: bib-update paper.pdf

paper.pdf: paper.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make paper.tex

clean:
	latexmk -CA


export BIBINPUTS ?= .:bib
bib:
ifdef PLUMEBIB
	ln -s ${PLUMEBIB} $@
else
	git clone https://github.com/mernst/plume-bib.git $@
endif
.PHONY: bib-update
bib-update: bib
# Even if this command fails, it does not terminate the make job.
# However, to skip it, invoke make as:  make NOGIT=1 ...
ifndef NOGIT
	-(cd bib && git pull && make)
endif
