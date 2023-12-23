#!/bin/bash

eval NEW_PYTHON_VERSION=3.11.7
eval SHORT_NEW_PYTHON_VERSION=${NEW_PYTHON_VERSION:0:4}

echo "Downloading Python"
mkdir -p /python && cd /python
wget https://www.python.org/ftp/python/$NEW_PYTHON_VERSION/Python-$NEW_PYTHON_VERSION.tar.xz
echo "Python Downloaded"

echo "Installing Python"
tar -xf Python-$NEW_PYTHON_VERSION.tar.xz
cd Python-$NEW_PYTHON_VERSION
./configure --enable-optimizations --with-lto
make altinstall
rm -r /python
echo "Python Installed"

echo "Setting enviromental variables"
cp /usr/local/bin/python$SHORT_NEW_PYTHON_VERSION /usr/bin/python$SHORT_NEW_PYTHON_VERSION
update-alternatives --install /usr/bin/python python /usr/bin/python$SHORT_NEW_PYTHON_VERSION 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python$SHORT_NEW_PYTHON_VERSION 1
echo "Finished"
