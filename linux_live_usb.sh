#!/usr/bin/env bash
DIR_DOWNLOADS="$HOME/Downloads/iso"
mkdir $DIR_DOWNLOADS
sudo dd if= "$DIR_DOWNLOADS/*.iso" of= 
echo "Instalação concluída."
