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
  "http://www.labcisco.com.br/app/Cisco-PT-71-x64.tar.gz" #cisco packet tracer
  "https://atom.io/download/deb" #atom
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
  expo-cli
)

#PROGRAMAS
SOFT_APT=(
  firefox
  telegram-desktop
  git
  ppa-purge
  python2
  python3
  dart
  snapd
  krita
  jupyter-notebook
  buttercup-desktop
  discord
  audacity
  dia #desenhar esquemas
  inkskape
  libreoffice
  scribus
  gvfs-bin
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
  clamav #antivirus
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

#instalando os .deb
for e in ./*.deb; do
  sudo dpkg -i $e
done

#Extraindo flutter
for e in ./*.tar*; do
  sudo tar xvzf $e -C $DIR_ANDROID
done

# Instalar programas apt
for e in ${SOFT_APT[@]}; do
  if ! dpkg -l | grep -q $e; then # Só instala se já não estiver instalado
    sudo apt -y install $e
  else
    echo "$e - INSTALADO"
  fi
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

#instalando brave
sudo sh -c 'echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com `lsb_release -sc` main" >> /etc/apt/sources.list.d/brave.list'
wget -q -O - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key add -
sudo apt -q update
sudo apt install brave-browser brave-keyring

#instalando insomnia
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
sudo apt -q update
sudo apt-get install insomnia


#tornando instaladores com mais passos executáveis
sudo chmod 777 ./*.run
sudo chmod 777 ./*.sh
sudo chmod 777 ./*.AppImage

#movendo Appimages para pasta de downloads
mv ./*.AppImage $DIR_SOFTWARES

FINAL_MSG="Finished"
#definindo path
PROFILE_PATH="$HOME/.profile"
PATH_ELEMENTS=(
  'export DIR_SOFTWARES="${HOME}/softwares"'
  '$ANDROID_HOME =${HOME}/Android/Sdk'
  'export PATH="${PATH}:/usr/lib/dart/bin"'
  'export PATH="${PATH}:${DIR_FLUTTER}/bin"'
  'export PATH="${PATH}:${ANDROID_HOME}/tools"'
  'export PATH=${PATH}:${ANDROID_HOME}/tools/bin'
  'export PATH="${PATH}:${ANDROID_HOME}/platform-tools"'
)


if [ -f $PROFILE_PATH ]; then
  for e in ${PATH_ELEMENTS[@]}; do
    echo $e >> $PROFILE_PATH
  done
  source $PROFILE_PATH
  flutter precache
else
  TMP_PATH = insert_in_path.txt

  for e in ${PATH_ELEMENTS[@]}; do
    echo $e >> $TMP_PATH
  done

  FINAL_MSG = ".profile not found, config your path with the paths in $HOME/TMP_PATH"
fi

#Atualizando sistema e limpando o lixo que tiver ficado
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y

echo FINAL_MSG
