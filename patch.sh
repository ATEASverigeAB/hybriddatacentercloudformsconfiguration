#!/bin/sh

## Variables
FILE=${1:-config/permissions.yml}

read -p "File to patch: [${FILE}]" MYFILE
FILE=${MYFILE:-${FILE}}


## Create Patch
vmdb
cp ${FILE} ${FILE}.old
vi ${FILE}
diff -u ${FILE}.old ${FILE} >~/AteaCloudformsConfiguration/patches/${FILE}.patch
rm ${FILE}.old


## Save Patch
cd ~/AteaCloudformsConfiguration
git add patches/${FILE}.patch
git commit -m "Added/Updated patches${FILE}.patch"
git push
