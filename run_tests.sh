#!/usr/bin/env bash
ENV=$(dirname $PWD)/env

echo $ENV
DIRECTORY=/tmp/hello

git archive --remote=../python_libs dev pure/rodeo | (mkdir -p $DIRECTORY && cd $DIRECTORY && tar xf -)

# Need to install the dependencies for the tests and the library

pushd $DIRECTORY/pure/rodeo
$ENV/bin/nosetests --where=tests/ -s
popd

rm -rf $DIRECTORY
