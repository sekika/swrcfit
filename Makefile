PREFIX := /usr/local

all:
	@echo "Nothing to compile. Run (sudo) make install."

install:
	@echo "=== Installing manual to $(DESTDIR)$(PREFIX)/share/man/man1"
	@mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	@cp swrcfit.1 $(DESTDIR)$(PREFIX)/share/man/man1/
	@gzip -f $(DESTDIR)$(PREFIX)/share/man/man1/swrcfit.1
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@sh Install.sh $(DESTDIR)$(PREFIX)/bin/
