MACHINE= $(shell uname -s)

FILENAME = GamaPaper

all: paper 

clean:
	-rm *.aux *.log *.dvi *.blg $(FILENAME).ps

paper: pdf

pdf: $(FILENAME).pdf

ps: $(FILENAME).ps

$(FILENAME).dvi: clean $(FILENAME).tex
ifeq ($(MACHINE),Linux)	
	cp -p emulateapj_template.cls emulateapj.cls
	latex $(FILENAME).tex
	latex $(FILENAME).tex
	bibtex $(FILENAME)
	latex $(FILENAME).tex
	latex $(FILENAME).tex
	rm emulateapj.cls
else # for texLive installed by macport that already includes emulateapj.cls 
	latex $(FILENAME).tex
	latex $(FILENAME).tex
	bibtex $(FILENAME)
	latex $(FILENAME).tex
	latex $(FILENAME).tex
endif

$(FILENAME).ps: $(FILENAME).dvi
	dvips -t a4 -o $(FILENAME).ps $(FILENAME).dvi

$(FILENAME).pdf: $(FILENAME).ps
	ps2pdf14 -dPDFsettings=/prepress $(FILENAME).ps

