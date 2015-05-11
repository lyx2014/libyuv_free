#!/bin/bash
ORIGDIR=`pwd`
TMPDIR=libyuv.$$

mkdir -p ../${TMPDIR}

cd ..
cp -a libyuv ${TMPDIR}/libyuv-0.0.1280
cd ${TMPDIR}
rm -rf libyuv-0.0.1280/.git*
tar zcvf libyuv-0.0.1280.tar.gz libyuv-0.0.1280
mv libyuv-0.0.1280.tar.gz ${ORIGDIR}/.
cd ${ORIGDIR}
rm -rf ../${TMPDIR}
