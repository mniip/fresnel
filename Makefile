CC= cc
MYCFLAGS= -Wall -Werror -std=c99 -O3
MYCPPFLAGS=
MYLINKFLAGS= -lm -lfftw3
OUTPUT= ./fresnel
SOURCE= fresnel.c

all: $(OUTPUT)

clean:
	rm -f $(OUTPUT)

$(OUTPUT): $(SOURCE)
	$(CC) -o $@ $+ $(MYCFLAGS) $(CFLAGS) $(MYCPPFLAGS) $(CPPFLAGS) $(MYLINKFLAGS) $(LINKFLAGS)

.PHONY: all clean
