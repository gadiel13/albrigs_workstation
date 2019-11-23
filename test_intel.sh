#!/usr/bin/env bash



#Configurando cstate
GRUB_PATH="./grub"
CONTENT_TO_INSERT=' intel_idle.max_cstate=1"'
TARGET_LINE="GRUB_CMDLINE_LINUX_DEFAULT"
NEW_STRING = "x"

#criando novo arquivo grub
while read line; do
  if [${line:0:26} == $TARGET_LINE]
  then
    $NEW_STRING =${line:0:-1}${CONTENT_TO_INSERT}
    echo $NEW_STRING >> $HOME/grub 
  else
    echo $line >> $HOME/grub
  fi
done < $GRUB_PATH
