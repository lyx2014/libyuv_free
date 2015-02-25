#!/bin/bash

if [ $# -eq 1 ]; then
	CHANGELOG=/tmp/changelog.tmp.$$

	echo "libyuv (0.0.1280-$1) stable; urgency=low" >$CHANGELOG
	cat >> $CHANGELOG << 'EOF'

  * AutoBuild Revision Update

 -- William King <william.king@quentustech.com>  Thu, 12 Feb 2015 09:47:31 -0800

EOF
	cat debian/changelog >> $CHANGELOG
	cp $CHANGELOG debian/changelog

fi

git-buildpackage --git-upstream-tree=origin/upstream -us -uc -sa --git-ignore-new
