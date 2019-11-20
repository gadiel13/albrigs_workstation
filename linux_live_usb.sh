#!/usr/bin/env bash
DIR_DOWNLOADS="$HOME/Downloads"

sudo dd if= "$DIR_DOWNLOADS/*.iso" of= -y
echo "Instalação concluída."