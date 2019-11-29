#!/usr/bin/env bash

iso

print('Qual o endereço do download da iso? Pode usar F12 e inspecionar o elemento para descobrir')
read(ISO)

DIR_DOWNLOADS="$HOME/Downloads/iso"

mkdir $DIR_DOWNLOADS
cd $DIR_DOWNLOADS

wget -C $ISO

sudo dd if= "./*.iso" of=




echo "Instalação concluída."
