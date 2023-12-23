#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please, run this script with root privileges"
  exit
fi

echo "Enter the new Python version: "
read NEW_PYTHON_VERSION
SHORT_NEW_PYTHON_VERSION=${NEW_PYTHON_VERSION:0:4}

echo "Installing system dependencies"
apt update
apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
echo "Dependencies installed"

echo "Downloading Python"
mkdir -p /python && cd /python
wget https://www.python.org/ftp/python/$NEW_PYTHON_VERSION/Python-$NEW_PYTHON_VERSION.tar.xz
echo "Python Downloaded"

echo "Installing Python"
tar -xf Python-$NEW_PYTHON_VERSION.tar.xz
cd Python-$NEW_PYTHON_VERSION
./configure --enable-optimizations  \
            --with-lto \
            --with-computed-gotos \
            --with-system-ffi \
            --enable-shared \
            --prefix=$PWD/run  \
            --libdir=$PWD/run/lib
make -j$(nproc)
make altinstall
rm -r /python
echo "Python Installed"

echo "Setting enviromental variables"
cp /usr/local/bin/python$SHORT_NEW_PYTHON_VERSION /usr/bin/python$SHORT_NEW_PYTHON_VERSION
update-alternatives --install /usr/bin/python python /usr/bin/python$SHORT_NEW_PYTHON_VERSION 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python$SHORT_NEW_PYTHON_VERSION 1
echo "Finished"
