TARGET = fpga

all:
	pandoc -t beamer \
		--latex-engine=xelatex \
		--variable fontsize=17pt \
		-H header.tex \
		-s $(TARGET).md \
		-o $(TARGET).pdf

clean:
	rm -f $(TARGET).pdf
