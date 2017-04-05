#!/usr/bin/env bash
# use git commit to remote git server
# git-commit.sh
# @author  xiaolei

echo -e "\033[33m**************************************\033[0m"
echo -e "commit local files to remote server"
echo -e "         author: xiaolei               "
echo -e "\033[33m**************************************\033[0m"

# git status
echo -e "\033[33m =========================\033[0m"
echo -e "\033[32m git status: \033[0m"
echo -e "\033[33m =========================\033[0m"
git status

# get current branch
echo -e "\033[33m=========================\033[0m"
branch=`git branch |grep '*'|xargs echo`
currentBranch=${branch:2}
echo -e "your current branch: ${currentBranch}"

# git add
echo -e "\033[33m==========================\033[0m"
read -p "git add --all?[y/n] " key
if [ ${key} = "y" ];then
    git add --all
    git status
else
    exit
fi

# git commit
echo -e "\033[33m==========================\033[0m"
read  -p "git commit?[y/n] " key
if [ ${key} = "y" ];then
    read -p "please input commit: " comment
    git commit -m "${comment}"
else
    exit
fi

# git push
echo -e "\033[33m==========================\033[0m"
echo -e "push to remote? y or n"
echo -e "\033[33m==========================\033[0m"
read key
if [ ${key} = "y" ];then
    git push
else
    exit
fi

# git checkout to public branch
echo -e "\033[33m=============================================\033[0m"
read -p "checkout to other branch and pull? [y/n] " key
if [ ${key} = "y" ];then
    read -p "please input the branch to checkout: " branchName
    echo -e "checkout ${branchName} and pull:"
    git checkout ${branchName}
    git pull
else
    exit
fi

# git checkout current branch and merge with branchName
echo -e "\033[33m===============================================================\033[0m"
read -p "checkout ${currentBranch} and merge with ${branchName}? [y/n] " key
if [ ${key} = "y" ];then
    git checkout ${currentBranch}
    git merge ${branchName}
else
    exit
fi

# git checkout branchName and merge with current branch
echo -e "\033[33m==============================================================\033[0m"
read -p  "checkout ${branchName} and merge with ${currentBranch}? [y/n] " key
if [ ${key} = "y" ];then
    git checkout ${branchName}
    git merge ${currentBranch}
else
    exit
fi

# git push to remote git server and checkout to current branch
echo -e "\033[33m=======================================================\033[0m"
read -p  "push to remote and checkout to ${currentBranch}? [y/n] " key
if [ ${key} = "y" ];then
    git push
    git checkout ${currentBranch}
else
    exit
fi
