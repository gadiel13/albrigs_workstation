#!/usr/bin/env bash
#Diretórios
DIR_DOWNLOADS="$HOME/DOWNLOADS"
DIR_SOFTWARES="$HOME/SOFTWARES"

#Urls a baixar
URL_ANDROID_STUDIO="https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz"
URL_FLUTTER="https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"
URL_MARK_TEXT="https://github.com/marktext/marktext/releases/download/v0.15.0/marktext-0.15.0-x86_64.AppImage"
#github softwares
URL_LIBRE_SPRITE='https://github.com/LibreSprite/LibreSprite.git'
URL_

#PROGRAMAS 
SOF_APT=(
    git
    python2
    python3
    dart
    snapd
    code
    krita
    buttercup-desktop
    discord
    audacity
    dia
    flatpak
    inkskape
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
)

SOFT_SNAP=(
    insomnia
)

SOFT_FLATPAK=(
    
)


# ---------------------------------------------------------------------- #
# Tirando travas do apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

#arquitetura 32 bits
sudo dpkg --add-architecture i386
sudo apt update -y

# ----------------------------- EXECUÇÃO ----------------------------- #

## Download e instalaçao de programas externos ##
mkdir "$DIR_SOFTWARES"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"

# Instalando todos os pacotes .deb
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done



## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install photogimp
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
#Atualizando sistema e limpando o lixo que tiver ficado
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #