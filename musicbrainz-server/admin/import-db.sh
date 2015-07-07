#!/bin/bash
cd $(dirname $0)/..

mkdir -p data
pushd data
rm -i *

set -e

function require {
  which $1 >/dev/null 2>&1 || (
    echo "$1" is required but could not be found
    exit 1
  )
}

MD5SUM=md5sum
CURL=curl
VAGRANT=vagrant

require $MD5SUM $CURL $VAGRANT

echo `date`: Fetching LATEST mbdump files
LATEST=$($CURL -s ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/LATEST)
for f in MD5SUMS mbdump{,-cover-art-archive,-derived,-documentation,-editor,-stats,-wikidocs}.tar.bz2
do
    echo `date`: Fetching "$f"
    test -e "$f" || \
        $CURL "ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/$f" \
            -o "$f"
done

$MD5SUM -c MD5SUMS

echo `date`: Running import on guest
popd

$VAGRANT up
$VAGRANT ssh -c "bash /vagrant/admin/guest/run-import.sh"
