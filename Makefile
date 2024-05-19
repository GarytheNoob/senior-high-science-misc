# Makefile for compiling LaTeX document with BibTeX

# Main document file (without extension)
MAIN = main

# Default target
all: $(MAIN).pdf

# Compile the PDF from the LaTeX sources
$(MAIN).pdf: $(MAIN).tex $(MAIN).bbl
	# Ensure the references are updated
	xelatex $(MAIN).tex
	xelatex $(MAIN).tex

# Generate the .bbl file using BibTeX
$(MAIN).bbl: $(MAIN).aux
	bibtex $(MAIN)
	# Generate .bbl and update .aux
	xelatex $(MAIN).tex

# Generate the .aux file by compiling the .tex file
$(MAIN).aux: $(MAIN).tex $(wildcard chap/*.tex) reference.bib
	# Generate .aux file
	xelatex $(MAIN).tex

# Clean auxiliary files
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.pdf

.PHONY: all clean
