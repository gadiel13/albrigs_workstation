#!/usr/bin/env bash

cd $HOME

#configurando xorg
XORG_PATH = "/etc/X11/xorg.conf.d/20-intel.conf"

sudo echo 'Section "Device"' >> $XORG_PATH
sudo echo '   Identifier "Intel Graphics"' >> $XORG_PATH
sudo echo '   Driver "intel"' >> $XORG_PATH
sudo echo '   Option "AccelMethod" "sna"' >> $XORG_PATH
sudo echo 'EndSection'  >> $XORG_PATH

#Configurando cstate
GRUB_PATH="/etc/default/grub"
CONTENT_TO_INSERT=' intel_idle.max_cstate=1"'
TARGET_LINE="GRUB_CMDLINE_LINUX_DEFAULT"
NEW_STR = "x"

#criando novo arquivo grub
while sudo read line; do
  if [${linen:0:26} == $TARGET_LINE]
  then
    $NEW_STR =${linen:0:-1}${CONTENT_TO_INSERT}
    echo $NEW_STR >> $HOME/grub 
  else
    echo $linen >> $HOME/grub
  fi
done < $GRUB_PATH

#Deletando o grub velho
sudo rm $GRUB_PATH

#Colocando grub novo
sudo mv $HOME/grub /etc/default/

#recarregando grub
sudo update-grub
