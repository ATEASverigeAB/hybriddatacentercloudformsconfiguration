#!/bin/sh


## Prerequisites
yum -y install git

## Prepare
cd $HOME
git clone https://github.com/anjan03/AteaCloudformsConfiguration.git
cd AteaCloudformsConfiguration

## Export CFME Database objects
for i in *
do
  miqexport $i $PWD/$i
done


## Export UI Customizations
cd /var/www/miq/vmdb/
cp -a -f --parents \
   ./public/assets/atea/                              \
   ./product/menubar/                                 \
   ./app/assets/stylesheets/main.scss                 \
   ./app/assets/stylesheets/icon_customizations.scss  \
   ./productization/assets/stylesheets/main.scss      \
   $HOME/AteaCloudformsConfiguration/vmdb/


## Save
#git add .
#git commit -m "`date +%Y%m%d` `hostname -f`"
#git push   -u origin master

