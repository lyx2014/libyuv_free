# This is a generic makefile for libyuv for gcc.
# make -f linux.mk CXX=clang++

PREFIX=/usr
LIBDIR=$(DESTDIR)/$(PREFIX)/lib/
INCDIR=$(DESTDIR)/$(PREFIX)/include/

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

all: libyuv.a libyuv.so convert

libyuv.a: $(LOCAL_OBJ_FILES)
	$(AR) $(ARFLAGS) $@ $(LOCAL_OBJ_FILES)

libyuv.so: $(LOCAL_OBJ_FILES)
	$(CXX) $(CXXFLAGS) $(LOCAL_OBJ_FILES) -o $@ $(LDFLAGS)

# A test utility that uses libyuv conversion.
convert: util/convert.cc libyuv.a
	$(CXX) $(CXXFLAGS) -Iutil/ -o $@ util/convert.cc libyuv.a

clean:
	/bin/rm -f source/*.o *.ii *.s libyuv.a convert

install: libyuv.a libyuv.so
	install -d -m 755 $(LIBDIR)
	install -d -m 755 $(INCDIR)
	install -d -m 755 $(INCDIR)/libyuv
	install -d -m 755 $(LIBDIR)/pkgconfig
	install -m 644 libyuv.a $(LIBDIR)
	install -m 644 libyuv.so $(LIBDIR)
	install -m 644 libyuv.pc $(LIBDIR)/pkgconfig
	install -m 644 include/libyuv.h $(INCDIR)
	install -m 644 include/libyuv/* $(INCDIR)/libyuv


