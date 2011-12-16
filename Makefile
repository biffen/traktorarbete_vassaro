#
# Author: Theo Willows
#

BOOK     = Traktorarbete_Vassaro

# Directories
DIR_IMG  = img
HTML_IMG = $(OUT_HTML)/img
OUT      = out
OUT_EPUB = $(OUT)/epub
OUT_HTML = $(OUT)/html
OUT_PDF  = $(OUT)/pdf

# Files
EPUB     = $(OUT_EPUB)/$(BOOK).epub
HTML     = $(OUT_HTML)/$(BOOK).html
IMGS     = img/*
PDF      = $(OUT_PDF)/$(BOOK).pdf
SRC      = $(BOOK).xml
XSL      = vassaro.xsl

# Programs
CP       = cp
DBLATEX  = dblatex
DBTOEPUB = dbtoepub
MKDIR    = mkdir
RM       = rm
XSLTPROC = xsltproc

all : $(HTML) $(PDF) $(EPUB)

$(HTML) : *.xml $(IMGS) $(XSL)
	$(MKDIR) -p $(OUT_HTML)
	$(CP) -rv $(DIR_IMG) $(HTML_IMG)
	$(XSLTPROC) --xinclude -o $(HTML) $(XSL) $(SRC)

$(PDF) : *.xml $(IMGS)
	$(MKDIR) -p $(OUT_PDF)
	$(DBLATEX) --pdf --backend=xetex --xslt-opts="--xinclude" -o $(PDF) $(SRC)

$(EPUB) : *.xml $(IMGS)
	$(MKDIR) -p $(OUT_EPUB)
	$(DBTOEPUB) -o $(EPUB) $(SRC)

clean :
	$(RM) -rvf $(OUT)

.PHONY: all clean
