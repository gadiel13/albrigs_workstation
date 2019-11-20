#!/usr/bin/env bash
#Diretórios
DIR_DOWNLOADS="$HOME/Downloads"
DIR_SOFTWARES="$HOME/softwares"
DIR_ANDROID="$DIR_SOFTWARES/android"
DIR_FLUTTER="$DIR_SOFTWARES/flutter"

#Urls a baixar
URLS_WGET=(
  "https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz" #android studio
  "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz" #flutter
  "https://github.com/marktext/marktext/releases/download/v0.15.0/marktext-0.15.0-x86_64.AppImage" #marktext
  "https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh" #anaconda
  "https://www.apachefriends.org/xampp-files/7.3.11/xampp-linux-x64-7.3.11-0-installer.run" #xampp

)

#git clone softwares
URL_GITHUB=(
  "https://github.com/LibreSprite/LibreSprite.git"
)

#instalar com pip
SOFT_PIP=(
  pelican
)

#instalar com npm -g
SOFT_NPM=(
  ionic
)
#PROGRAMAS 
SOF_APT=(
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
  dia
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
  g++ 
  libx11-dev 
  libxcursor-dev 
  cmake 
  ninja-build
  hugo  
)

SOFT_SNAP=(
  insomnia
)

SOFT_FLATPAK=(

)

# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

#arquitetura 32 bits
sudo dpkg --add-architecture i386
sudo apt update -y

#instalando flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y

#instalando mark text
sudo flatpak install flathub com.github.marktext.marktext -y

## Download e instalaçao de programas externos ##
mkdir "$DIR_SOFTWARES"

for e in ${URLS_WGET[@]}; do
  wget -c "$e" -P "$DIR_DOWNLOADS"
  echo "$e - BAIXADO";
done


#descompactando todos os tar
for e in $DIR_DOWNLOADS/*.tar.*; do
  sudo -C # tar -xzvf "$e";
done

# Instalar programas apt
for e in ${SOF_APT[@]}; do
  if ! dpkg -l | grep -q $e; then # Só instala se já não estiver instalado
    sudo apt install "$e" -y
  else
    echo "$e - INSTALADO"
  fi
done

# Instalar programas snap
for e in ${SOF_APT[@]}; do
  sudo snap install "$e" -y
done

#xampp
sudo chmod 777 $DIR_DOWNLOADS/*.run
sudo ./*.run


#Atualizando sistema e limpando o lixo que tiver ficado
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y



# export PATH="$PATH:`pwd`/flutter/bin"
# flutter precache

#cd LibreSprite
#mkdir build
#cd build
#cmake -DCMAKE_INSTALL_PREFIX=~/software -G Ninja ..
#ninja libresprite

