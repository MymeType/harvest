###################################################   

compiler = clang
options  = 
linker   = -lluajit-5.1
output   = harvest
sources  = ./src/main.c

$(output): $(sources)
	$(compiler) -o ./src/$(output) $(sources) $(options) $(linker)

PREFIX = /usr

###################################################   

clean:
	rm -f $(output) *.o

###################################################

install:
	mkdir -p $(DESTDIR)$(PREFIX)/lib/grain/$(output)/
	luajit -b ./src/main.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/main.lua
	luajit -b ./src/config.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/config.lua
	luajit -b ./src/remove.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/remove.lua
	luajit -b ./src/update.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/update.lua
	luajit -b ./src/list.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/list.lua
	luajit -b ./src/fetch.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/fetch.lua
	luajit -b ./src/clean.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/clean.lua
	luajit -b ./src/info.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/info.lua
	luajit -b ./src/help.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/help.lua
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp ./src/$(output) $(DESTDIR)$(PREFIX)/bin/

###################################################

local:
	mkdir -p ~/.local/bin/
	cp ./src/$(output) ~/.local/bin/
	mkdir -p ~/.local/share/grain/$(output)/
	luajit -b ./src/main.lua ~/.local/share/grain/$(output)/main.lua

###################################################

test:
	mkdir -p $(DESTDIR)$(PREFIX)/lib/grain/$(output)/
		luajit -b ./src/main.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/main.lua
		luajit -b ./src/config.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/config.lua
	mkdir -p $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/
		luajit -b ./src/arguments/remove.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/remove.lua
		luajit -b ./src/arguments/update.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/update.lua
		luajit -b ./src/arguments/list.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/list.lua
		luajit -b ./src/arguments/fetch.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/fetch.lua
		luajit -b ./src/arguments/clean.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/clean.lua
		luajit -b ./src/arguments/info.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/info.lua
		luajit -b ./src/arguments/help.lua $(DESTDIR)$(PREFIX)/lib/grain/$(output)/arguments/help.lua
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
		$(compiler) $(options) -o $(DESTDIR)$(PREFIX)/bin/$(output) $(sources) $(linker)

###################################################
