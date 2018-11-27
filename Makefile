SDCC=sdcc
SRCDIR=./src
BINDIR=./bin
INCLUDES=\
	./vendor/stm8s/inc \
	./vendor/button_debounce/inc
CFLAGS=$(foreach d, $(INCLUDES),-I$d) --nolospre

.PHONY: all clean

all: main

clean:
	rm -rf $(BINDIR)/

main: $(BINDIR)/main.hex

$(BINDIR)/%.hex: $(SRCDIR)/%.c
	mkdir -p $(BINDIR)/ &&\
	$(SDCC) -lstm8 -mstm8 -o $(BINDIR)/ --out-fmt-ihx $(CFLAGS) $(LDFLAGS) $< &&\
	mv $$(echo "$@" | sed -e 's/\.hex$$/\.ihx/g') $@
