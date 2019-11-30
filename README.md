# Minha workstation
Estes scripts são os que eu normalmente uso para configurar meu computador pessoal e fazer algumas tarefas simples.

Sempre utilizo sistemas baseados em [Ubuntu](https://ubuntu.com/), não foram feitos testes em outros tipos de distribuições e provavelmente haverão problemas em alguams que tenham características similares.

Para utiliza-los execute os seguintes comandos em seu terminal substituindo **filename** pelo nome do script que deseja executar.

```
$ # Você deve estar com o terminal apontando para a pasta onde o script está
$ sudo chmod 777 filename.sh && sudo ./filename.sh
```

## Os seguintes scripts estão presentes:
* __pos_install.sh:__ programas que utilizo para desenvolvimento e edição de midia;
* __my_fonts.sh:__ baixa e instala as fontes tipográficas que utilizo frequentemente em projetos gráficos;
* __linux_live_usb.sh:__  cria pendrive live a partir de um arquivo na pasta de downloads;
* __old_intel.sh:__ muda a opção do grub de cs_state_max para evitar travamentos em computadores antigos que utilizam processadores intel.
* __wp_install.sh:__ extrai o arquvo wordpress do zip em sua pasta de downloads e transporta para a pasta htdocs, tornando ela livre para editar.

