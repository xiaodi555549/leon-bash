#!/usr/bin/env bash
# use this shell script to get the soc and pisces dirctory
# from the remote server to your local svn directory.
#----------------------------------------------------------------------------------
# NOTE: before you use it, you must copy the file to your root path of soc project
# and then open the file, modify path_svn to your local svn directory.
# ----------------------------------------------------------------------------------
# author: xiaolei 2016-06-20
#


# remote branch
remote_branch="dev"

# local svn path
path_svn="/T/website/soc-svn"

# tar file name
tar_file="soc-remote.tar.gz"

# git server
git_server="10.65.120.68"

# remote path
path_remote="/home/fanhengyang/soc-web"


# display git server
echo -e  "\033[33m remote git server:${git_server} \033[0m"

# check path_svn exists
[ -d ${path_svn} ] || { echo "can not find path: ${path_svn}, please correct the path_svn variable in the shell script file! "; exit 1;}

# login git server and tar the soc
ssh root@${git_server} <<EOF
cd ${path_remote}
git branch -a
sleep 3
git checkout ${remote_branch}
git branch -a
sleep 3
git pull
tar -zcvf ./${tar_file} soc pisces
EOF

# get the package form git server
scp -r root@${git_server}:${path_remote}/${tar_file} ${path_svn}

cd ${path_svn}

# delete soc and  pisces directory
rm -r soc pisces

# extract the tar.gz
tar -zxvf ${tar_file}