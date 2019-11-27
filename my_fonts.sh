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
for key in ${!FONTS_FOLDERS[@]}; do $ARR_FOLDERS+=( `$key ${ary[$key]}` ); done
cd ..

for e in ./fonts; do
  if[ -d $e ]; then
    mv $e/* $DOWNLOADS_DIR

#alterando permissões das fontes
sudo chown root:staff $FONTS_DIR -R
sudo chmod 644 $FONTS_DIR/* -R
sudo chmod 755 $FONTS_DIR

#recarregando fontes
sudo fc-cache -fv
