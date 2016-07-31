include meta.make

###############################################################################

all: $(FILE_BASE_NAME).pdf

.PHONY : all clean init pdf ps html jdhp publish

SRCARTICLE=macros_common.tex\
		   macros.tex\
		   bibliography.bib\
		   setup_package*.tex\
		   main.tex\
		   content/*.tex

SRCTIKZ=

###############################################################################

# PDF #############

pdf: $(FILE_BASE_NAME).pdf

$(FILE_BASE_NAME).pdf: $(SRCARTICLE) $(SRCTIKZ)
	pdflatex -jobname=$(FILE_BASE_NAME) main.tex
	bibtex $(FILE_BASE_NAME)            # this is the name of the .aux file, not the .bib file !
	pdflatex -jobname=$(FILE_BASE_NAME) main.tex
	pdflatex -jobname=$(FILE_BASE_NAME) main.tex

# PS ##############

#ps: $(FILE_BASE_NAME).ps
#
#$(FILE_BASE_NAME).ps: $(SRCARTICLE) $(SRCTIKZ)
#	latex -jobname=$(FILE_BASE_NAME) main.tex
#	bibtex $(FILE_BASE_NAME)            # this is the name of the .aux file, not the .bib file !
#	latex -jobname=$(FILE_BASE_NAME) main.tex
#	latex -jobname=$(FILE_BASE_NAME) main.tex
#	dvips $(FILE_BASE_NAME).dvi

# HTML ############

html: $(FILE_BASE_NAME).html

$(FILE_BASE_NAME).html: $(SRCARTICLE) $(SRCTIKZ)
	hevea -fix -o $(FILE_BASE_NAME).html main.tex
	bibhva $(FILE_BASE_NAME)            # this is the name of the .aux file, not the .bib file !
	hevea -fix -o $(FILE_BASE_NAME).html main.tex

# PUBLISH #####################################################################

publish: jdhp

jdhp:$(FILE_BASE_NAME).pdf $(FILE_BASE_NAME).html

	# PDF #############
	
	# JDHP_DL_URI is a shell environment variable that contains the destination
	# URI of the PDF files.
	@if test -z $$JDHP_DL_URI ; then exit 1 ; fi
	
	# Upload the PDF file
	rsync -v -e ssh $(FILE_BASE_NAME).pdf ${JDHP_DL_URI}/pdf/

	# HTML ############
	
	# JDHP_DOCS_URI is a shell environment variable that contains the
	# destination URI of the HTML files.
	@if test -z $$JDHP_DOCS_URI ; then exit 1 ; fi

	# Copy HTML
	@rm -rf $(HTML_TMP_DIR)/
	@mkdir $(HTML_TMP_DIR)/
	cp -v $(FILE_BASE_NAME).html $(HTML_TMP_DIR)/
	cp -vr figs $(HTML_TMP_DIR)/

	# Upload the HTML files
	rsync -r -v -e ssh $(HTML_TMP_DIR)/ ${JDHP_DOCS_URI}/$(FILE_BASE_NAME)/

## CLEAN ######################################################################

clean:
	@echo "Remove generated files"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.nav *.snm *.bbl *.blg *.vrb
	@rm -f *.haux *.htoc *.hbbl $(FILE_BASE_NAME).image.tex
	@rm -rf $(HTML_TMP_DIR)

init: clean
	@echo "Remove target files"
	@rm -f $(FILE_BASE_NAME).pdf
	@rm -f $(FILE_BASE_NAME).ps
	@rm -f $(FILE_BASE_NAME).html

