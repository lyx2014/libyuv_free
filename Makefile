# This is a generic makefile for libyuv for gcc.
# make -f linux.mk CXX=clang++

PREFIX:=/usr
EXEC_PREFIX:=$(PREFIX)
LIBDIR:=$(PREFIX)/lib/
INCDIR:=$(PREFIX)/include/

CXX?=g++
CXXFLAGS?=-O2 -fomit-frame-pointer -fpic
CXXFLAGS+=-Iinclude/
LDFLAGS      = -shared

LOCAL_OBJ_FILES := \
    source/compare.o           \
    source/compare_common.o    \
    source/compare_posix.o     \
    source/convert.o           \
    source/convert_argb.o      \
    source/convert_from.o      \
    source/convert_from_argb.o \
    source/convert_to_argb.o   \
    source/convert_to_i420.o   \
    source/cpu_id.o            \
    source/planar_functions.o  \
    source/rotate.o            \
    source/rotate_argb.o       \
    source/rotate_mips.o       \
    source/row_any.o           \
    source/row_common.o        \
    source/row_mips.o          \
    source/row_posix.o         \
    source/scale.o             \
    source/scale_argb.o        \
    source/scale_common.o      \
    source/scale_mips.o        \
    source/scale_posix.o       \
    source/video_common.o

.cc.o:
	$(CXX) -c $(CXXFLAGS) $*.cc -o $*.o

all: libyuv.a libyuv.so convert libyuv.pc

libyuv.a: $(LOCAL_OBJ_FILES)
	$(AR) $(ARFLAGS) $@ $(LOCAL_OBJ_FILES)

libyuv.so: $(LOCAL_OBJ_FILES)
	$(CXX) $(CXXFLAGS) $(LOCAL_OBJ_FILES) -o $@ $(LDFLAGS)

# A test utility that uses libyuv conversion.
convert: util/convert.cc libyuv.a
	$(CXX) $(CXXFLAGS) -Iutil/ -o $@ util/convert.cc libyuv.a

clean:
	/bin/rm -f source/*.o *.ii *.s libyuv.a convert

libyuv.pc: libyuv.pc.in
	sed -e "s;@prefix@;$(PREFIX);" -e "s;@exec_prefix@;$(EXEC_PREFIX);" -e "s;@libdir@;$(LIBDIR);" -e "s;@includedir@;$(INCDIR);" libyuv.pc.in > $@

install: libyuv.a libyuv.so libyuv.pc
	install -d -m 755 $(DESTDIR)/$(LIBDIR)
	install -d -m 755 $(DESTDIR)/$(INCDIR)
	install -d -m 755 $(DESTDIR)/$(INCDIR)/libyuv
	install -d -m 755 $(DESTDIR)/$(LIBDIR)/pkgconfig
	install -m 644 libyuv.a $(DESTDIR)/$(LIBDIR)
	install -m 644 libyuv.so $(DESTDIR)/$(LIBDIR)
	install -m 644 libyuv.pc $(DESTDIR)/$(LIBDIR)/pkgconfig
	install -m 644 include/libyuv.h $(DESTDIR)/$(INCDIR)
	install -m 644 include/libyuv/* $(DESTDIR)/$(INCDIR)/libyuv


