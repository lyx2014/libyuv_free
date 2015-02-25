#!/bin/bash

if [ $# -eq 1 ]; then
	CHANGELOG=/tmp/changelog.tmp.$$

	cat >> $CHANGELOG << EOF
libyuv (0.0.1280-$1) stable; urgency=low

  * AutoBuild Revision Update

 -- FreeSWITCH Autobuild <autobuild@freeswitch.org>  `date -R`

EOF
	cat debian/changelog >> $CHANGELOG
	cp $CHANGELOG debian/changelog
	rm $CHANGELOG

fi

git-buildpackage --git-upstream-tree=origin/upstream -us -uc -sa --git-ignore-new
