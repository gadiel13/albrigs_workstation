#!/usr/bin/env bash

cd $HOME

configurando xorg
 mkdir /etc/X11/xorg.conf.d/
XORG_PATH = "/etc/X11/xorg.conf.d/20-intel.conf"

sudo echo 'Section "Device"' >> $XORG_PATH
sudo echo '   Identifier "Intel Graphics"' >> $XORG_PATH
sudo echo '   Driver "intel"' >> $XORG_PATH
sudo echo '   Option "AccelMethod" "sna"' >> $XORG_PATH
sudo echo 'EndSection'  >> $XORG_PATH

#Configurando cstate
GRUB_FOLDER="/etc/default"
GRUB_PATH="${GRUB_FOLDER}/grub"

CONTENT_TO_INSERT=' intel_idle.max_cstate=1"'
TARGET_LINE="GRUB_CMDLINE_LINUX_DEFAULT"

#copiando uma versão de backup caso haja erros
cp /etc/default/grub ./grub_previous

#criando novo arquivo grub
while read line; do
  rad_line=${line:0:26}
  if [ "$rad_line"!="$TARGET_LINE" ];then
    echo "$line" >> $HOME/grub
  else
    I=$((${#HOME} -1))
    new_line="${line:0:$I}"
    NEW_STR=""${new_line}""${CONTENT_TO_INSERT}""
    echo "${NEW_STR}" >> $HOME/grub
  fi
done < ./grub_previous

#Deletando o grub velho
sudo rm $GRUB_PATH

#Colocando grub novo
sudo cp $HOME/grub /etc/default/

#recarregando grub
sudo update-grub
