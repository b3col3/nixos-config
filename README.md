# Configuration NixOs

## Instalation

1) Se déplacer dans le dossier de configuration : `sudo cd /etc/nixos`
2) Cloner le repo avec les droits admin (sudo)
3) Copier le fichier env.example.json en env.json : `sudo cp env.example.json env.json`
4) compléter le fichier fichier env.json
5) Lancer la commande d'installation (avec les droits administrateur) : `sudo nixos-rebuild switch --upgrade --flake .`
