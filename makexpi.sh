#!/bin/sh
APP_NAME=https-everywhere

# builds a .xpi from the git repository, placing the .xpi in the root
# of the repository.

# invoke with no arguments to pull a prerelease of the current
# development point.

# invoke with a tag name to build a specific branch.

# e.g.:
#  ./makexpi.sh 0.2.3.development.2

# or just:
#  ./makexpi.sh

if [ "$1" ] ; then
    VERSION="$1"
    TARG="$1"
else
    VERSION="$(grep em:version src/install.rdf | sed -e 's/[<>]/	/g' | cut -f3)~pre"
    TARG=HEAD
fi
XPI_NAME="pkg/$APP_NAME-$VERSION.xpi"

cd "$(dirname $0)/src"
git archive --format=zip -9 "$TARG" . > "../$XPI_NAME"
ret="$?"
if [ "$ret" != 0 ]; then
    rm -f "../$XPI_NAME"
    exit "$?"
fi
