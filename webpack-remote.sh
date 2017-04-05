#!/usr/bin/env bash
# this shell is to generate pisces direcotry to execute webpack in the remote machine
# author: xiaolei

# remote branch
remote_branch="dev"

# git server
git_server="10.65.120.68"

# remote path
path_remote="/home/fanhengyang/soc-web"

echo -e "\033[33m******  webpack remote server ${git_server}  ******\033[0m"

ssh root@${git_server} <<EOF
cd ${path_remote}
git branch -a
sleep 3
git checkout ${remote_branch}
git branch -a
sleep 3
git pull
echo -e "\033[33m webpack...\033[0m"
webpack
EOF
