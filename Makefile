SDCC=sdcc
SDCCLIB=sdcclib
SRCDIR=./src
BINDIR=./bin
INCLUDES=\
./vendor/stm8s/inc\
./vendor/button_debounce/inc
CFLAGS=--nolospre $(addprefix -I,$(INCLUDES))
LDFLAGS=--out-fmt-ihx
APP_SOURCE_FILES=$(shell find $(SRCDIR) -name "*.c")
LIB_SOURCE_FILES=$(shell find $(INCLUDES) -name "*.c")
APP_OBJECTS=$(subst /./,/,$(addprefix $(BINDIR)/,$(APP_SOURCE_FILES:.c=.rel)))
LIB_OBJECTS=$(subst /./,/,$(addprefix $(BINDIR)/,$(LIB_SOURCE_FILES:.c=.rel)))

.PHONY: all build clean

all: build

build: $(BINDIR)/program.hex

$(BINDIR)/program.hex: $(APP_OBJECTS) $(BINDIR)/vendor.lib
	$(SDCC) -mstm8 -lstm8 -o $@ $(LDFLAGS) $^

$(BINDIR)/%.rel: %.c
	mkdir -p $(dir $@) &&\
	$(SDCC) -mstm8 -o $@ -c $(CFLAGS) $^

$(BINDIR)/vendor.lib: $(LIB_OBJECTS)
	$(SDCCLIB) $@ $^

%.c: %.h

clean:
	rm -rf $(BINDIR)/
