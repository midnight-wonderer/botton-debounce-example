SDCC=sdcc
SRCDIR=./src
BINDIR=./bin
INCLUDES=\
./vendor/stm8s/inc\
./vendor/button_debounce/inc
CFLAGS=--nolospre $(addprefix -I,$(INCLUDES))
LDFLAGS=--out-fmt-ihx
SOURCE_FILES=\
$(shell find $(SRCDIR) -name "*.c")\
$(shell find $(INCLUDES) -name "*.c")
OBJECTS=$(subst /./,/,$(addprefix $(BINDIR)/,$(SOURCE_FILES:.c=.rel)))

.PHONY: all build clean

all: build

build: $(BINDIR)/program.hex

$(BINDIR)/program.hex: $(OBJECTS)
	$(SDCC) -mstm8 -lstm8 -o $@ $(LDFLAGS) $^

$(BINDIR)/%.rel: %.c
	mkdir -p $(dir $@) &&\
	$(SDCC) -mstm8 -o $@ -c $(CFLAGS) $^

%.c: %.h

clean:
	rm -rf $(BINDIR)/
