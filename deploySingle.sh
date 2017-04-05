#!/bin/sh
# author: leon
# copy one file to remote machine
# note: don't have '/' before path

echo -e "single file path："
read file

echo -e "target ip："
read targetIp


scp $file root@$targetIp:/opt/nsfocus/espc/www/$file


