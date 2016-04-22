#!/usr/bin/bash
CURRENT_DIR=$PWD
curl -kL https://raw.githubusercontent.com/saghul/pythonz/master/pythonz-install | bash
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc 
pythonz install 2.5.6

mkdir packages -p

PYPI_PACKAGE_URL=https://pypi.python.org/packages/source

pushd packages/
curl $PYPI_PACKAGE_URL/p/pip/pip-1.3.1.tar.gz | tar xz
curl $PYPI_PACKAGE_URL/s/setuptools/setuptools-1.4.2.tar.gz | tar xz
curl $PYPI_PACKAGE_URL/v/virtualenv/virtualenv-1.9.1.tar.gz | tar xz
popd

PYTHON=$(pythonz locate 2.5.6)
PYDIR=$(dirname $PYTHON)

pushd packages/virtualenv-1.9.1
$PYTHON setup.py install --quiet
popd

VIRTUALENV=$PYDIR/virtualenv
ENV=$CURRENT_DIR/env

$VIRTUALENV --distribute -p $PYTHON $ENV

PY25BIN=$ENV/bin/python

pushd packages/setuptools-1.4.2
$PY25BIN setup.py install --quiet
popd

pushd packages/pip-1.3.1
$PY25BIN setup.py install --quiet
popd

$ENV/bin/pip install --insecure -r requirements.txt
