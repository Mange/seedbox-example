#!/usr/bin/env bash

# Run all apps as the "seedbox" user, but the "samba" group as that is the
# group that owns all files in the library.
{
  echo "PUID=$(id -u seedbox)"
  echo "PGID=$(id -g samba)"
  echo "TZ=Europe/Stockholm"
} > user.env

mkd() {
  local path="$1"

  if [ ! -d "$path" ]; then
    sudo mkdir "$path"
    sudo chown seedbox:seedbox "$path"
  fi
}


mkd Transmission
mkd Transmission/Config
mkd Transmission/Watch
sudo chmod -R ug=rwX,o=rX Transmission

mkd Jackett
mkd Jackett/Config
sudo chmod -R ug=rwX,o=rX Jackett

mkd Sonarr
mkd Sonarr/Config
sudo chmod -R ug=rwX,o=rX Sonarr

mkd Bazarr
mkd Bazarr/Config
sudo chmod -R ug=rwX,o=rX Bazarr

mkd Muximux
mkd Muximux/Config
sudo chmod -R ug=rwX,o=rX Muximux

