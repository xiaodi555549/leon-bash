#!/usr/bin/env bash
# deploy front end files to remote machine
# -------------------------------------------------------------------------
# note: before deploy make sure you generate the pisces directory with webpack
# add modle dopoly
# useage: ./tool/deploySoc.sh -m 'moduleName'
# ------------------------------------------------------------------------
# author: xiaolei
# date: 2016-08-29


# path remote
path_remote="/opt/nsfocus/espc/www"

# deploy all soc code 
if [ $# -eq 0 ]; then

    # tar file name
    tar_file="soc-web.tar.gz"

    # tar the soc and pisces directory
    tar -zcvf ${tar_file} soc pisces


# deploy a module in soc project
elif [ $# -eq 2 ] && [ $1 = '-m' ]; then
    module_name=$2
    soc_module_path=soc/apps/${module_name}

    # check the dirctory exist
    [ ! -d ${soc_module_path} ] && { echo "module do not exsist, please check your module name!"; exit; }

    pisces_js_path="pisces/js/${module_name}.bundle.js"
    pisces_css_path="pisces/css/${module_name}.css"
    pisces_module_path="pisces/${module_name}/index.html"

    tar_file="soc-${module_name}.tar.gz"
    tar -zcvf ${tar_file} $soc_module_path ${pisces_js_path} ${pisces_css_path} ${pisces_module_path}

# give the correct module deploy foramt
else
    echo "Error format, You must use: ./deploySoc.sh -m moduleName"
    exit
fi


# read the target ip
read -p "please input the target ip: " targetIp

# copy the gzip file to the remote machine
scp  ${tar_file} root@${targetIp}:${path_remote}

# login in remote machine and unzip the gzip package, in the end delete the gzip package
ssh root@${targetIp}<<EOF
cd ${path_remote}
tar -zxvf ${tar_file}
rm -f ${tar_file}
EOF

# delete local gzip package
rm -f ${tar_file}


