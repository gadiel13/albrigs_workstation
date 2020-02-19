#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt --fix-broken

#Diretórios
DIR_DOWNLOADS="$HOME/Downloads/fromscript"
DIR_SOFTWARES="$HOME/softwares"
DIR_FLUTTER="$DIR_SOFTWARES/flutter"
DIR_ANDROID="$DIR_SOFTWARES/android"
#Urls a baixar
URLS_WGET=(
  "https://github.com/simlu/voxelshop/releases/download/1.8.26/voxelshop-bin.zip"
  "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz" #flutter
  "https://github.com/marktext/marktext/releases/download/v0.15.0/marktext-0.15.0-x86_64.AppImage" #marktext
  "https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh" #anaconda
  "https://www.apachefriends.org/xampp-files/7.3.11/xampp-linux-x64-7.3.11-0-installer.run" #xampp
  "https://atom.io/download/deb" #atom
  "https://github.com/minbrowser/min/releases/download/v1.7.0/Min_1.7.0_amd64.deb" #navegador minimalista
  "http://downloads.raspberrypi.org/rpd_x86/images/rpd_x86-2019-10-01/2019-09-25-rpd-x86-buster.iso"
  "http://tinycorelinux.net/10.x/x86/release/Core-10.1.iso"
)

#instalar com pip
SOFT_PIP=(
  pelican
  kivy
  jupyterthemes
  gdown
  pyinstaller
  virtualenv
  youtube-dl
  pipreqs
  pymodore
  twine
)

#instalar com npm -g
SOFT_NPM=(
  ionic
  n
  expo-cli
)


#PROGRAMAS -> primeiro as libs que são dependências
SOFT_APT=(
  swig
  gvfs-bin
  g++
  libx11-dev
  libxcursor-dev
  cmake
  ninja-build
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
  liballegro4.4
  libdevil1c2
  libphysfs1
  cmake
  ninja-build
  ffmpeg
  xz-utils
  build-essential
  checkinstall
  libssl-dev
  gconfig2
  upx #fundamental para gerar executáveis com kivy
  firefox
  telegram-desktop
  snapd
  git
  ppa-purge
  python2
  python3
  python3-pip
  portaudio19-dev
  python-all-dev
  dart
  krita
  jupyter-notebook
  buttercup-desktop
  discord
  audacity
  dia #desenhar esquemas
  inkskape
  libreoffice
  scribus
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
  unzip
  clamav #antivirus
  npm
  xclip
  pikopixel.app
  virtualbox
  retroarch
  megasync
  inkscape
  dia
  bluetooth
  bluez
  bluez-tools
  rfkill
  blueman
  flatpak
  snaped
  love
  wget 
  gnupg 
  software-properties-common
  android-sdk
  android-sdk-platform-23
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

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt update -y
sudo apt install adoptopenjdk-8-hotspot -y

cd $DIR_DOWNLOADS

for e in ${URLS_WGET[@]}; do
  wget -c "$e"
  echo "$e - BAIXADO";
done

#acertando o nome do pacote deb
mv deb atom.deb

# Instalar programas apt
for e in ${SOFT_APT[@]}; do
  if ! dpkg -l | grep -q $e; then # Só instala se já não estiver instalado
    sudo apt -f -y install $e
  else
    echo "$e - INSTALADO"
  fi
done

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub com.github.libresprite.LibreSprite
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community

#instalando os .deb
for e in ./*.deb; do
  sudo dpkg -i $e
done
sudo rm -R ./*.deb

# Instalar programas pip
for e in ${SOFT_PIP[@]}; do
  pip3 install $e
done

# Instalar programas npm
for e in ${SOFT_NPM[@]}; do
  sudo npm install -g $e
done

#Download piskel
gdown 'https://drive.google.com/uc?export=download&id=1EFo7Ye_rl7bGNr4iehXIgFg4gn2IcWDX'

#descompactações
for e in ./*.zip; do
  unzip $e
done

for e in ./*.tar; do
  tar -xvf $e
done

for e in ./*.tar.gz; do
  tar -xvzf $e
done

for e in ./*.tar.bz2; do
  tar -xvjf $e
done

for e in ./*.tar.xz; do
  tar -xf $e
done

sudo rm ./*.tar*
sudo rm ./*.zip

#renomeando pasta piskel
mv ./Piskel* ./piskel


#Configurando retro arch
ROMS = $SOFTWARES_DIR/roms
mkdir $ROMS



sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

snap install code --classic
snap install hugo

#node version manager
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash

#Desbloqueando bluetooth
sudo rfkill unblock bluetooth

#trocando java
sudo update-alternatives --config java

#instalando insomnia
sudo snap install insomnia
sudo snap install goxel
sudo snap install hugo

#tornando instaladores com mais passos executáveis
sudo chmod 777 ./*.run
sudo chmod 777 ./*.sh
sudo chmod 777 ./*.AppImage

#movendo Appimages para pasta de downloads
sudo mv ./* $DIR_SOFTWARES

#trocando o tema do jupyter
jt -t chesterish

mkdir $HOME/pyenvs

FINAL_MSG="Finished"
#definindo path
PROFILE_PATH="$HOME/.profile"
STRING_SPACE = ' '
PATH_ELEMENTS=(
  'DIR_SOFTWARES="${HOME}/softwares"'
  'ANDROID_HOME =/usr/lib/android-sdk'
  'PATH="${PATH}:/usr/lib/dart/bin"'
  'PATH="${PATH}:$DIR_SOFTWARES/flutter/bin"'
  'PATH="${PATH}:${ANDROID_HOME}/tools"'
  'PATH=${PATH}:${ANDROID_HOME}/tools/bin'
  'PATH="${PATH}:${ANDROID_HOME}/platform-tools"'
  ''
  '#softwares a invocar'
  'lampp=/opt/lampp/lampp'
  'marktext=$DIR_SOFTWARES/marktext*'
  'pycharm=$DIR_SOFTWARES/pycharm-anaconda/bin/pycharm.sh'
  'piskel=$DIR_SOFTWARES/piskel/piskel'
  'roms=${DIR_SOFTWARES}/roms'
  'pyenvs=${HOME}/pyenvs'
  'ytdl="youtube-dl --extract-audio --audio-format mp3"'
  'libresprite="flatpak run com.github.libresprite.LibreSprite"'
)


if [ -f $PROFILE_PATH ]; then
  for e in ${PATH_ELEMENTS[@]}; do
    echo'export' $e >> $PROFILE_PATH
  done
  source $PROFILE_PATH
  flutter precache
else
  TMP_PATH = insert_in_path.txt

  for e in ${PATH_ELEMENTS[@]}; do
    echo 'export' $e >> $TMP_PATH
  done

  FINAL_MSG = ".profile not found, config your path with the paths in $HOME/TMP_PATH"
fi

#Atualizando sistema e limpando o lixo que tiver ficado
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

cd $DIR_SOFTWARES

sudo chmod 777 ./Anaconda*
sudo ./Anaconda*

sudo chmod 777 ./xampp*
sudo ./xampp

cd android-studio/bin
sudo chmod 777 ./studio.sh
./studio.sh


echo FINAL_MSG
echo "All softwares and instalers are in $DIR_SOFTWARES"

