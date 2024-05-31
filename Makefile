# Makefile for compiling LaTeX document with BibTeX and MakeIndex

# Main document file (without extension)
MAIN = main

# Default target
all: $(MAIN).pdf

# Compile the PDF from the LaTeX sources
$(MAIN).pdf: $(MAIN).tex $(MAIN).bbl $(MAIN).idx
	# Compile the LaTeX document
	xelatex $(MAIN).tex
	# Run MakeIndex to process index
	makeindex $(MAIN).idx
	# Compile the LaTeX document again to update references and index
	xelatex $(MAIN).tex
	xelatex $(MAIN).tex

# Generate the .bbl file using BibTeX
$(MAIN).bbl: $(MAIN).aux
	bibtex $(MAIN)

# Generate the .idx file using MakeIndex
$(MAIN).idx: $(MAIN).aux
	# Ensure .idx is generated if needed
	touch $(MAIN).idx

# Generate the .aux file by compiling the .tex file
$(MAIN).aux: $(MAIN).tex $(wildcard chap/*.tex) reference.bib
	# Generate .aux file
	xelatex $(MAIN).tex

# Clean auxiliary files
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.pdf *.idx *.ilg *.ind

.PHONY: all clean
