#!/bin/bash
#
echo "Checking For Steam Link SDK..."
source ../../setenv.sh

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"


echo "Preparing for Build..."
rm $parent_path/output/SDLPoP-steamlink/prince
rm $parent_path/output/SDLPoP-steamlink.tgz

cd src
echo "Building SDLPoP-steamlink..."
make clean
make -f Makefile.steamlink || exit 2

echo "Creating Installation Package..."
cd ..
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

mv $parent_path/prince $parent_path/output/prince
cp $parent_path/output/prince $parent_path/output/SDLPoP-steamlink/prince

# Pack it up
export DESTDIR="${PWD}/output/SDLPoP-steamlink/"
cd output

name=$(basename ${DESTDIR})
tar zcvf $name.tgz $name || exit 3

echo "Build Complete! Check in /output/ directory."

