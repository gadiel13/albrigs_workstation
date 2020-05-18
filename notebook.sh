#!/usr/bin/env bash

# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

#arquitetura 32 bits
sudo dpkg --add-architecture i386
sudo apt-key adv --recv-key --keyserver keyserver.ubuntu.com 241FE6973B765FAE
sudo apt update
sudo apt upgrade
sudo apt --fix-broken install

read -p 'E-mail github: ' GIT_EMAIL
read -p 'User github: ' GIT_NAME

I_APT=(
	#Gerenciadores de pacotes
	snapd
	flathub
	#Programação
	python3
	default-jdk
	openjdk-8-jdk
	python3-pip
	npm
	r-base
	r-base-dev
	spyder
	jupyter-notebook
	#Midia
	ffmpeg
	okular
	audacity
	#Web
	transmission
	firefox
	apt-transport-https
	preload
	putty
	telegram-desktop
	discord
	#Texto
	xclip
	nano
	#Graficos
	dia
	krita
	inkskape
	scribus
	#outras
	buttercup-desktop
	git
	ppa-purge
	gufw
	xz-utils
	clamav
	font-manager
	libreoffice
	virtualbox
	retroarch
	pikopixel.app
	wget
	unzip
	bash
)


R_APT=(
	audacious
	audacious-plugins
	audacious-plugins-data
	simple-scan
	atril
	atril-common
	chromium-browser
)

I_PIP=(
	pyinstaller
	virtualenv
	pipreqs
	youtube-dl
	pymodore
	jupyterthemes
)

I_NPM=(
	n
	gitmoji-cli
)

I_SNAP=(
	hugo
	insomnia
)

URLS_WGET=(
	"https://atom.io/download/deb" #atom
	"https://github.com/minbrowser/min/releases/download/v1.7.0/Min_1.7.0_amd64.deb" #navegador minimalista
	"https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip"
	"https://github.com/simlu/voxelshop/releases/download/1.8.26/voxelshop-bin.zip"
	"https://github.com/marktext/marktext/releases/download/v0.15.0/marktext-0.15.0-x86_64.AppImage"
	"https://www.apachefriends.org/xampp-files/7.3.11/xampp-linux-x64-7.3.11-0-installer.run"
)

I_ATOM=(
	#Genéricos
	file-icons
	atom-clock
	teletype
	highlight-selected
	pigments
	autocomplete-paths
	pane-layout-plus
	expose
	sublime-style-column-selection
	platformio-ide-terminal
	todo-show

	#html
	emmet
	autoclose-html-plus
	atom-html-preview

	#git
	git-blame
	git-plus
	git-time-machine

	#python
	autocomplete-python
	python-isort

	#dart
	dart

	#js
)

## Download e instalaçao de programas externos ##
for e in ${URLS_WGET[@]}; do wget -c "$e" && echo "$e - BAIXADO"; done
mv deb atom.deb

# Instalar programas apt
for e in ${R_APT[@]}; do sudo apt -y remove $e; done
sudo apt --fix-broken install
for e in ./*.deb; do sudo dpkg -i $e; done
for e in ${I_PIP[@]}; do sudo pip3 install $e; done
for e in ${I_SNAP[@]}; do sudo snap install $e; done
for e in ${I_NPM[@]}; do sudo npm install -g $e; done
for e in ${I_APT[@]}; do if ! dpkg -l | grep -q $e; then sudo apt -f -y install $e; fi; done
for e in ${I_ATOM[@]}; do apm install $e; done

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.github.libresprite.LibreSprite

#dart
sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt-get update
sudo apt-get install dart

#logando no github
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL

#descompactando até a alma
for e in ./*.zip; do unzip $e; done
for e in ./*.tar; do tar -xvf $e; done
for e in ./*.tar.gz; do tar -xvzf $e; done
for e in ./*.tar.bz2; do tar -xvjf $e; done
for e in ./*.tar.xz; do tar -xf $e; done

#flutter
git clone https://github.com/flutter/flutter.git -b stable
sudo mv flutte* /usr/lib

#android sdk cli
sudo mkdir /usr/lib/android-sdk
sudo mv tools /usr/lib/android-sdk

sudo chmod 777 ./xampp*
sudo ./xampp*

#apagando tudo
sudo rm ./*.tar* && sudo rm ./*.zip && sudo rm -R ./*.deb && sudo rm xampp*

echo "Use o JDK 8"
sudo update-alternatives --config java

#definindo path
PROFILE_PATH="$HOME/.profile"

PATH_ELEMENTS=(
	'ANDROID_SDK_ROOT=/usr/lib/android-sdk'
	'ANDROID_HOME=/usr/lib/android-sdk'
	'PATH=${PATH}:$ANDROID_HOME/tools'
	'PATH=${PATH}:$ANDROID_HOME/tools/bin'
	'PATH=${PATH}:$ANDROID_HOME/platform-tools'
	'PATH=${PATH}:/usr/lib/dart/bin'
	'PATH=${PATH}:/usr/lib/flutter/bin'
	'PATH=${PATH}:/usr/lib/dart/bin'
)

for e in ${PATH_ELEMENTS[@]}; do echo 'export' $e >> $PROFILE_PATH; done
source $PROFILE_PATH

# TODO -> trocar no SDK manager DEFAULT_JVM_OPTS='"-Dcom.android.sdklib.toolsdir=$APP_HOME" -XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
sdkmanager --sdk_root=$ANDROID_SDK_ROOT
sdkmanager "system-images;android-29;google_apis;x86_64"
sdkmanager "platforms;android-29"
sdkmanager "platform-tools"
sdkmanager "patcher;v4"
sdkmanager "build-tools;29.0.2"

flutter config --android-sdk /usr/lib/android-sdk

# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean && sudo apt autoremove -y

flutter doctor

echo "ACABOU :^), hora do reboot"
echo -en "\007"
