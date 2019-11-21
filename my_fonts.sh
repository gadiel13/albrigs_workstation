#!/usr/bin/env bash
DOWNLOADS_DIR="$HOME/Downloads"
$DOWNLOADS_DIR git clone https://github.com/opensourcedesign/fonts.git

FONTS_DIR ="/usr/local/share/fonts/ms_fonts"

#movendo das 
for e in ${FONTS_DIR[@]}; do
    for i in $e/*tf; done
        sudo mv i $FONTS_DIR
    done
done

#alterando permissões das fontes
sudo chown root:staff $FONTS_DIR -R
sudo chmod 644 $FONTS_DIR/* -R
sudo chmod 755 $FONTS_DIR

#recarregando fontes
sudo fc-cache -fv