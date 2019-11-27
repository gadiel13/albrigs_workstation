#!/usr/bin/env bash

echo "Nome da pasta do site. escrito-desse-jeito"
read  NAME
echo "Deletar o arquivo compactado do wordpress em $HOME?"
echo "s para sim. Qualquer outra coisa que você digitar será considerado não."
read DELETE

cd $HOME

if [ -f $HOME/latest-pt_BR.zip ]; then
  echo "você já tinha um arquivo com o nome do zip com o nome do baixado do site wordpress. Deseja baixar outro?"
  echo "s para sim. Qualquer outra coisa que você digitar será considerado não."
  read BAIXAR
  if[ $BAIXAR = "s" ]; then
    wget -c https://br.wordpress.org/latest-pt_BR.zip
  fi
else
    wget -c https://br.wordpress.org/latest-pt_BR.zip
fi

unzip ./latest-pt_BR.zip

rm ./latest-pt_BR.zip

mv ./wordpress ./$NAME

sudo mv ./$NAME /opt/lampp/htdocs



#só pro caso de esquecer
sudo chmod 777 -R /opt/lampp

