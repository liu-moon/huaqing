#!/bin/bash
#cd /~
cd /home/liuiu/liuweiqi
mkdir subdir1 subdir2
cp /etc/passwd ./subdir1
cp /etc/group ./subdir2
#cp /etc/passwd subdir1
#cp /etc/group subdir2
mv subdir2 subdir
tar -cvf subdir1.tar.xz subdir1
cp subdir1.tar.xz subdir
cd subdir
tar -xvf subdir1.tar.xz
ls
