#!/bin/sh

zipFile="espc-web.tar.gz"

if ! [ -d "build/src" ] ; then
	mkdir -p build/src
fi

cp index.html build/src
cp favicon.ico build/src
cp -r slave build/src
cp -r download build/src
cp -r media build/src
cp -r swift build/src
cp -r upload build/src

if ! [ -d "build/deploy" ] ; then
	mkdir -p build/deploy
fi

#zip
cd build/src/
#zip -r $zipFile build/src/*
tar zcvf $zipFile *
cd ../../
mv build/src/$zipFile build/deploy/
rm -rf build/src




#copy
echo -e "\033[32m Deploy target IP: \033[0m"
read targetIP
scp build/deploy/$zipFile root@$targetIP:/opt/nsfocus/espc/

#ssh and unzip
ssh root@$targetIP "tar zxvf /opt/nsfocus/espc/"${zipFile} -C /opt/nsfocus/espc/www/

#kill mock and restart
#kill -9 `ps -ef | grep mockApi.js | grep -v grep | awk '{print $2;}'`
#nohup node /opt/nsfocus/espc-web/test/mockApi.js &
#exit