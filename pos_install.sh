#!/usr/bin/env bash
#Diretórios
DIR_DOWNLOADS="$HOME/Downloads/fromscript"
DIR_SOFTWARES="$HOME/softwares"
DIR_FLUTTER="$DIR_SOFTWARES/flutter"
DIR_LIBRESPRIT="$DIR_SOFTWARES/LibreSprite "
DIR_ANACONDA="$DIR_SOFTWARES/anaconda"

#Urls a baixar
URLS_WGET=(
  "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz" #flutter
  "https://github.com/marktext/marktext/releases/download/v0.15.0/marktext-0.15.0-x86_64.AppImage" #marktext
  "https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh" #anaconda
  "https://www.apachefriends.org/xampp-files/7.3.11/xampp-linux-x64-7.3.11-0-installer.run" #xampp
)

#instalar com pip
SOFT_PIP=(
  pelican
  kivy
)

#instalar com npm -g
SOFT_NPM=(
  ionic
  n
)
#PROGRAMAS 
SOFT_APT=(
  firefox
  telegram-desktop
  git
  python2
  python3
  dart
  snapd
  code
  krita
  jupyter-notebook
  buttercup-desktop
  discord
  audacity
  dia #desenhar esquemas
  inkskape
  libreoffice
  scribus
  libvulkan1
  libvulkan1:i386
  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
  libc6:i386
  libncurses5:i386
  libstdc++6:i386
  lib32z1
  libbz2-1.0:i386
  hugo  #criador de sites estáticos
  font-manager
  default-jre #java mais recente
  openjdk-8-jre #java 8
  nano #editor de texto
  apt-transport-https #transportador https
  curl
  okular
  preload
  filezilla
  gufw
  synaptic
  putty
)

SOFT_SNAP=(
  insomnia
  brave
  notepadqq
)

# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

#arquitetura 32 bits
sudo dpkg --add-architecture i386
sudo apt -y update

## Download e instalaçao de programas externos ##
mkdir $DIR_SOFTWARES
mkdir $DIR_FLUTTER
mkdir $DIR_ANDROID
mkdir $DIR_ANACONDA
mkdir $DIR_DOWNLOADS
#fazendo downloads
cd $DIR_DOWNLOADS
for e in ${URLS_WGET[@]}; do
  wget -c "$e"
  echo "$e - BAIXADO";
done

#Extraindo flutter
sudo tar xvzf ./flutter* -C $DIR_ANDROID

# Instalar programas apt
for e in ${SOFT_APT[@]}; do
  if ! dpkg -l | grep -q $e; then # Só instala se já não estiver instalado
    sudo apt -y install $e
  else
    echo "$e - INSTALADO"
  fi
done

# Instalar programas snap
for e in ${SOFT_SNAP[@]}; do
  sudo snap  install $e
done

# Instalar programas pip
for e in ${SOFT_PIP[@]}; do
  pip install $e
done

# Instalar programas npm
for e in ${SOFT_NPM[@]}; do
  sudo npm install -g $e
done

#instalar android-studio (ele precisa de uma flag classic)
sudo snap install android-studio --classic

#tornando instaladores com mais passos executáveis
sudo chmod 777 ./*.run
sudo chmod 777 ./*.sh
sudo chmod 777 ./*.AppImage

#movendo Appimages para pasta de downloads
mv ./*.AppImage $DIR_SOFTWARES

FINAL_MSG = "Finished"
#definindo path
PROFILE_PATH = "$HOME/.profile"
if [ -f $PROFILE_PATH ]; then
	echo 'export DIR_SOFTWARES="$HOME/softwares"' >> $PROFILE_PATH
	echo '$ANDROID_HOME =$HOME/Android/Sdk' >> $PROFILE_PATH
	echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> $PROFILE_PATH
	echo 'export PATH="$PATH:${DIR_FLUTTER}/bin"' >> $PROFILE_PATH
	echo 'export PATH="$PATH:${ANDROID_HOME}/tools"' >> $PROFILE_PATH
	echo 'export PATH="$PATH:${ANDROID_HOME}/platform-tools"' >> $PROFILE_PATH
	source $PROFILE_PATH
	flutter precache
else
	TMP_PATH = insert_in_path.txt

        echo 'export DIR_SOFTWARES="$HOME/softwares"' >> $TMP_PATH
        echo '$ANDROID_HOME =$HOME/Android/Sdk' >> $TMP_PATH
        echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> $TMP_PATH
        echo 'export PATH="$PATH:${DIR_FLUTTER}/bin"' >> $TMP_PATH
        echo 'export PATH="$PATH:${ANDROID_HOME}/tools"' >> $TMP_PATH
        echo 'export PATH="$PATH:${ANDROID_HOME}/platform-tools"' >> $TMP_PATH

	FINAL_MSG = ".profile not found, config your path with the paths in $HOME/insert_in_path.txt"
fi

#Atualizando sistema e limpando o lixo que tiver ficado
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

echo FINAL_MSG
