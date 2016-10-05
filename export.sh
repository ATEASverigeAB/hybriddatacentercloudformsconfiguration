#!/bin/sh


## Prerequisites
echo "## Installing git"
rpm --quiet -q git && echo "Already installed" || yum -y install git

## Prepare
echo
echo "## Downloading AteaCloud Configuration repository"
cd $HOME
git clone https://github.com/anjan03/AteaCloudformsConfiguration.git
cd AteaCloudformsConfiguration

## Export CFME Database objects
for i in `ls -d * |egrep -v "vmdb|port.sh"`
do
  echo
  echo "## Export " $i
  miqexport $i $PWD/$i
done


## Export UI Customizations
echo
echo "## Export UI Customizations"
cd /var/www/miq/vmdb/
cp -a -f --parents \
   ./public/assets/atea/                              \
   ./product/menubar/                                 \
   ./app/assets/stylesheets/main.scss                 \
   ./app/assets/stylesheets/icon_customizations.scss  \
   ./productization/assets/stylesheets/main.scss      \
   $HOME/AteaCloudformsConfiguration/vmdb/


## Save
echo
echo "## Upload AteaCloud Configuration repository"
cd $HOME/AteaCloudformsConfiguration
git add .
git commit -m "`date +%Y%m%d` `hostname -f`"
git push   -u origin master

