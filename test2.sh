#!/bin/bash
mypath=$PATH
myhome=$HOME
flag=$myhome
myhome=$mypath
mypath=$flag
echo $myhome
echo $mypath