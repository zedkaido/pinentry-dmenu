DATE      = $$(date +'%B %Y')
VERSION   = 1.0
BUGREPORT = https:\/\/github.com\/zedkaido\/pinentry-dmenu

PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
FREETYPEINC = /usr/include/freetype2

OS := $(shell uname -s)
ifeq ($(OS),Linux)
	X11INC = /usr/X11R6/include
	X11LIB = /usr/X11R6/lib
	FREETYPEINC = /usr/include/freetype2
endif

ifeq ($(OS), OpenBSD)
	X11INC = /usr/X11R6/include
	X11LIB = /usr/X11R6/lib
	FREETYPEINC = $(X11INC)/freetype2
	MANPREFIX = ${PREFIX}/man
endif

ifeq ($(OS),Darwin)
	X11INC = /opt/X11/include
	X11LIB = /opt/X11/lib
	BREW_FREETYPE = $(shell brew --prefix freetype 2>/dev/null || echo "/usr/local/bin/freetype")
	FREETYPEINC = $(BREW_FREETYPE)/include/freetype2 
endif

XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

FREETYPELIBS = -lfontconfig -lXft

# ls $(brew --prefix libgpg-error)/include/
# /opt/homebrew/opt/libgpg-error/include/

INCS = -I$(X11INC) -I$(FREETYPEINC) -I/opt/homebrew/include
LIBS = -L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS) -L/opt/homebrew/lib

# CPPFLAGS = -D_DEFAULT_SOURCE -D_POSIX_C_SOURCE=200809L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS} -DPACKAGE_VERSION=\"${VERSION}\" -DPACKAGE_BUGREPORT=\"${BUGREPORT}\"
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\" $(XINERAMAFLAGS) -DPACKAGE_VERSION=\"${VERSION}\" -DPACKAGE_BUGREPORT=\"${BUGREPORT}\"
CFLAGS   = -std=c99 -pedantic -Wall -Os $(INCS) $(CPPFLAGS) 
LDFLAGS  = $(LIBS)

# compiler and linker
CC = cc
