#!/usr/bin/bash
CURRENT_DIR=$PWD
curl -kL https://raw.githubusercontent.com/saghul/pythonz/master/pythonz-install | bash
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc 
pythonz install 2.5.6
 
wget https://pypi.python.org/packages/source/p/pip/pip-1.3.1.tar.gz
wget https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
wget https://pypi.python.org/packages/a5/f9/0c604ce96292da59301c062689b1380594382c70f27b279522f5d7add9c2/virtualenv-1.9.1.tar.gz

tar xfz pip-1.3.1.tar.gz
tar xfz setuptools-1.4.2.tar.gz
tar xfz virtualenv-1.9.1.tar.gz

PYTHON=$(pythonz locate 2.5.6)
PYDIR=$(dirname $PYTHON)

pushd virtualenv-1.9.1
$PYTHON setup.py install
popd

VIRTUALENV=$PYDIR/virtualenv

$VIRTUALENV -p $PYTHON $HOME/.virtualenvs/py25

PY25BIN=$HOME/.virtualenvs/py25/bin/python 

pushd setuptools-1.4.2
$PY25BIN setup.py install
popd

pushd pip-1.3.1
$PY25BIN setup.py install
popd

$HOME/.virtualenvs/py25/bin/pip install --insecure -r requirements.txt
