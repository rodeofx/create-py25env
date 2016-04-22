#!/usr/bin/env bash
ENV=$PWD/env

echo $ENV
DIRECTORY=/tmp/hello

git archive --remote=../python_libs dev pure/rodeo | (mkdir -p $DIRECTORY && cd $DIRECTORY && tar xf -)

# Need to install the dependencies for the tests and the library

PYTHONPATH=/rdo/rodeo/workgroups/maya/scripts
PYTHONPATH=$PYTHONPATH:/software/alembic/linux/current/lib
PYTHONPATH=$PYTHONPATH:/software/qube/linux/current/api/python

pushd $DIRECTORY/pure/rodeo
$ENV/bin/nosetests --where=tests/ -s
popd

rm -rf $DIRECTORY
