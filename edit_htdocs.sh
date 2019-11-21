DIR_DOWNLOADS=$HOME/Downloads

unzip $DIR_DOWNLOADS/wordpress*.zip

sudo mv $DIR_DOWNLOADS/wordpress /opt/lampp/htdocs

#só pro caso de esquecer
sudo chmod 777 -R /opt/lampp

