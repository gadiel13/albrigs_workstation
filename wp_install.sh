#!/usr/bin/env bash

echo "Site directory name. like-this-example"
read  NAME

DIR_DOWNLOADS=$HOME/Downloads
$DIR_DOWNLOADS wget -c https://br.wordpress.org/latest-pt_BR.zip

unzip $DIR_DOWNLOADS/latest-pt_BR.zip

rm $DIR_DOWNLOADS/latest-pt_BR.zip

mv $DIR_DOWNLOADS/wordpress $DIR_DOWNLOADS/$NAME

sudo mv $DIR_DOWNLOADS/$NAME /opt/lampp/htdocs



#só pro caso de esquecer
sudo chmod 777 -R /opt/lampp

