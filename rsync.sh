#!/bin/sh

src_dir="/opt/nsfocus/espc/pisces/"
dst_dir="/opt/nsfocus/espc/www/"
exclude_file="/opt/nsfocus/espc/pisces/tool/exclude.list"
zipFile="soc-www-backup_"`date +%Y-%m-%d-%H-%M-%S`".tar.gz"
local=false
while getopts "bl" arg
do case $arg in
    l)
        # sync to local
        local=true
        ;;
    b)  
        # build local files
        echo "Start Building Local Files..."
        cd /opt/nsfocus/espc/pisces/pisces
        rm -rf *
        cd /opt/nsfocus/espc/pisces/
        npm run build
        echo "Done!"
        ;;
    ?)
        echo "unknow input"
        exit 1
        ;;
   esac
done

# Backup destination directory
if $local; then
    echo "Start updateing Local Files..."
        svn update /opt/nsfocus/espc/www
    echo "Done"
	echo "Start Backuping Local Files..."
        tar zcvf /opt/nsfocus/espc/${zipFile} /opt/nsfocus/espc/www/*
	echo "Done"
	echo "Start Synching Files From Dev To Build..."
	rsync -rltvp --delete --progress --exclude-from=$exclude_file $src_dir $dst_dir
	echo "Done"
else
	echo -e "\033[32m Deploy target IP: \033[0m"
	read targetIP
	echo "Start Backuping Remote Files..."
	ssh root@$targetIP "tar zcvf /opt/nsfocus/espc/"${zipFile} /opt/nsfocus/espc/www/*
	echo "Done!"
	echo "Start Synching Local Files To Remote..."
	rsync -rltvp --delete --progress --exclude-from=$exclude_file $src_dir root@$targetIP:$dst_dir
	echo "Done"
fi

# Sync files
# -t: sync the modify time of src_dir
# -I: slow mode
# -r: sync directory
# -l: sync soft link without follow link
# -L: sync soft link with follow link
# -p: perserve permissions
# -delete: sync deleted files
# -exclude: ingore files
# -exclude-from: ingore files list
