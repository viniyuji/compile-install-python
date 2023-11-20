#!/bin/bash

sudo su

mkdir /python
cd /python
wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tar.xz
tar -xf Python-3.11.4.tar.xz
cd Python-3.11.4
./configure --enable-optimizations --with-lto
make altinstall
rm -r /python

cp /usr/local/bin/python3.11 /usr/bin/python3.11
update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1