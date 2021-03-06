#!/usr/bin/env bash

# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

#arquitetura 32 bits
sudo dpkg --add-architecture i386
sudo apt-key adv --recv-key --keyserver keyserver.ubuntu.com 241FE6973B765FAE
sudo apt update
sudo apt -y upgrade
sudo apt -y --fix-broken install

read -p 'E-mail github: ' GIT_EMAIL
read -p 'User github: ' GIT_NAME

I_APT=(
	#Gerenciadores de pacotes
	snapd
	flatpak
	#Programação
	python3
	default-jdk
	openjdk-8-jdk
	python3-pip
	npm
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
	#Texto
	xclip
	nano
	#Graficos
	dia

	git
	ppa-purge
	gufw
	xz-utils
	clamav
	wget
	unzip
	bash
	android-sdk
	libglu1-mesa
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
)

I_NPM=(
	n
	gitmoji-cli )

I_SNAP=(
	hugo
	insomnia
	wps-office
)

URLS_WGET=(
  "https://atom.io/download/deb" #atom
  "https://github.com/minbrowser/min/releases/download/v1.7.0/Min_1.7.0_amd64.deb" #navegador minimalista
  "https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip"
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
sudo apt -y --fix-broken install
for e in ./*.deb; do sudo dpkg -i $e; done
sudo apt -y --fix-broken install

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
sudo mv tools /usr/lib/android-sdk

#apagando tudo
sudo rm ./*.tar* && sudo rm ./*.zip && sudo rm -R ./*.deb

echo "Use o JDK 8"
sudo update-alternatives --config java

#definindo path
PROFILE_PATH="$HOME/.profile"

PATH_ELEMENTS=(
	'ENABLE_FLUTTER_DESKTOP=true'
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

flutter channel master
flutter upgrade
flutter doctor 

# Concertando audio dessa merda
sudo cp /usr/share/alsa/ucm/chtrt5645/ /usr/share/alsa/ucm/chtrt5650/
sudo mv /usr/share/alsa/ucm/chtrt5650/chtrt5645.conf /usr/share/alsa/ucm/chtrt5650/chtrt5650.conf

wget https://apt.galliumos.org/pool/main/g/galliumos-skylake/galliumos-skylake_2.0.2_all.deb
sudo dpkg --ignore-depends=galliumos-base -i galliumos-skylake_2.0.2_all.deb

sudo apt -qq update
sudo apt full-upgrade

echo "ACABOU :^), hora do reboot"
echo -en "\007"
