# weaves

# AM_CFLAGS ?= -DNDEBUG

## qoxygen2 is the original
## qoxygen is the newer one that uses some C++ and counts lines.

BUILT_SOURCES = mtoc1.cc lex.cc qlex.cc

noinst_PROGRAMS = string0 rtocc

string0_SOURCES = string0.cc

bin_PROGRAMS = mtoc rtoc qoxygen qoxygen2

LDADD = -L$(top_srcdir)/lib -lgnu $(LEXLIB)

rtoc_SOURCES=rtoc1.c xmalloc.c lex.hh rtoc.l

qoxygen2_SOURCES = qoxygen.l

lex.cc: rtocc.l
	flex -+ $(FLEX_DEBUG) -o $@ $<

mtoc1.cc: mtoc.l
	flex -+ $(FLEX_DEBUG) -o $@ $<

rtocc_SOURCES = rtocc1.cc xmalloc.c lex.cc

mtoc_SOURCES = rtocc1.cc mtoc1.cc xmalloc.c rtocc2.cc

qoxygen_SOURCES = rtocc1.cc xmalloc.c rtoc.1 \
 qlex.cc rtocc2.cc

qlex.cc: qoxygen2.l
	flex -+ $(FLEX_DEBUG) -o $@ $<

CLEANFILES = qoxygen.c lex.yy.cc lex.yy.c rtoc.c $(BUILT_SOURCES)

#  uncomment the following if mtoc requires the math library
#mtoc_LDADD=-lm

EXTRA_DIST = mtoc.lsm.in mtoc.spec.in mtoc.texinfo \
 rtocc.l matlab-sample.m R-sample.R R-sample1.R \
 tester fdoxy qoxygen.l qoxygen2.l \
 mtoc.l xmalloc.c system.h aclocal.m4 mtoc.1

#  build and install the .info pages
# info_TEXINFOS = mtoc.texinfo
# mtoc_TEXINFOS = ../gpl.texinfo

#  install the man pages
man_MANS = mtoc.1 rtoc.1

export TOP = $(top_srcdir)
export srcdir

TESTS_ENVIRONMENT = $(SHELL) -x tester
XFAIL_TESTS = 

# TESTS = matlab-sample.m R-sample.R R-sample1.R example.q
TESTS = example2.q example.q R-sample.R 

clean-local:
	-rm -f  *~ *-sample.c *-sample.log make.log cscope.*

distclean-local:
	rm -rf docs/*

doc:
	:> rtoc-doc.log
	rm -rf docs/*
	$(DOXYGEN) 
