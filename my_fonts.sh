#!/usr/bin/env bash
DOWNLOADS_DIR="$HOME/Downloads/fonts"
mkdir $DOWNLOADS_DIR
cd $DOWNLOADS_DIR

git clone https://github.com/opensourcedesign/fonts.git

FONTS_DIR ="/usr/local/share/fonts/ms_fonts"
if [ ! -f $FONTS_DIR ]; then
  mkdir $FONTS_DIR

#movendo fontes pra fora das pastas
cd fonts
$FONTS_FOLDERS=`ls`
$ARR_FOLDERS = ()

for key in ${!FONTS_FOLDERS[@]}; do
	$ARR_FOLDERS+=( `$key ${ary[$key]}` ) #capturando os endereços das pastas
done

for e in ${ARR_FOLDERS[@]}; do
	sudo mv $e/* $FONTS_DIR #movendo tudo de dentro de cada pasta para a pasta de fontes
done

sudo rm -R DIR_DOWNLOADS #deletando as pastas que sobraram

#alterando permissões das fontes
sudo chmod -R 755 $FONTS_DIR

#recarregando fontes
sudo fc-cache -fv
