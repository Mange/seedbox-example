# seedbox

This is an example configuration for a "Seedbox". You can use it to download
Linux ISOs 24/7. This example is written so that it can run on a normal
Raspberry Pi 3.

Services are wrapped in Docker containers to make installation and upgrades
simpler.

I'm not sure if it works or not since I clearly don't run a seedbox; I'm happy
with my normal Linux ISO downloads, thank you very much.

## Setup

Install docker and docker-compose.

**Hint:** On Raspberry PI, install docker-compose via pip:

```
sudo pip install docker-compose
```

Set up the user and bootstrap the project.

```
sudo adduser --disabled-password seedbox # Create new user and group
sudo gpasswd -a "$(whoami)" seedbox      # Add yourself to the group too
sudo gpasswd -a seedbox samba            # Add user to the group owning the Downloads dir

cd /home/seedbox                         # Here's where we'll set this up
./setup.sh

# Symlink media storage directories
ln -s /path/to/downloads Transmission/Downloads
ln -s /path/to/series Sonarr/Library

docker-compose up -d                     # Boot up the services
```

Install nginx config and load up the root of the subdomain and start to
configure the services.

### Muximux

Add these services:

  - Transmission: `/transmission/web`
  - Jackett: `/jackett`
  - Sonarr: `/sonarr`

### Jackett

Activate some trackers you like.

### Sonarr

Configure it as you wish. Use Jackett to add Trackers.

**Note:** Sonarr is pretty bad at finding Linux ISOs. Be careful so you don't
download anything copyrighted.

## Upgrading

```
cd /home/seedbox
docker-compose stop
docker-compose pull
docker-compose up -d
```
