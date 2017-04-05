#!/bin/sh
# author: leon
# copy more file in one directory  to remote machine
# note: don't have '/' before path
# todo have some error

if ! [ -d "build/src" ] ; then
	mkdir -p build/src
fi

if ! [ -d "build/deploy" ] ; then
	mkdir -p build/deploy
fi

echo -e "directory path："
read dir

echo -e "more files split with one blank space"

read files


# handle files
OLD_IFS="$IFS"
IFS=" "
arr=($files)
IFS="$OLD_IFS"
for file in ${arr[@]}
do
     cp $dir$file build/src
done

read -p "press any key to continue"

#zip
cd build/src/
zipFile="espc-dir.tar.gz"

#zip -r $zipFile build/src/*
tar zcvf $zipFile *

cd ../../
rm -rf build/src


# get target ip
echo -e "target ip："
read targetIp

# copy files
scp build/deploy/$zipFile root@$targetIP:/opt/nsfocus/espc/

#ssh and unzip
ssh root@$targetIP "tar zxvf /opt/nsfocus/es