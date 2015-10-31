# hearstat/alpine-hubot
Hubot running on [Alpine](https://hub.docker.com/_/alpine/) with the [Hipchat Adapter](https://github.com/hipchat/hubot-hipchat).

# Build Info
## NODE
- NodeJS: 4.2.1
- NPM: 2.24.9

## Default Scripts
- [hubot-hipchat](https://github.com/hipchat/hubot-hipchat)
- hubot-diagnostics
- hubot-help
- hubot-google-images
- hubot-google-translate
- hubot-pugme
- hubot-maps
- hubot-redis-brain
- hubot-rules
- hubot-shipit
- hubot-pager-me
- hubot-chef
- hubot-plusplus
- hubot-tell
- hubot-devops-reactions
- hubot-team
- hubot-github-repo-event-notifier
- hubot-reload-scripts
- hubot-jenkins
- hubot-jenkins-notifer

## Installed Packages
- bash
- supervisor
- nodejs
- redis
- build-base
- gc
- g++
- gcc-objc
- libtool
- libc6-compat
- make
- expat
- expat-dev
- python
- wget
- gnupg
- tar
- git
- zip
- curl
- wget

## Suggested Mounts
Mount the redis directory to avoid data reset on container replacement
- /var/lib/redis

Mount the scripts directory for script storage/easy addition
- /opt/hubot/scripts

Mount a customer configuration file, see below for more info
- /opt/hubot/hubot.conf

# Usage
You have a few options in how to utilize this container

## Basic Start

```
docker run -v -e HUBOT_HIPCHAT_JID=jid \
  -e HUBOT_HIPCHAT_PASSWORD=secret \
  -e HUBOT_AUTH_ADMIN=admin \
  -d hearstat/alpine-hubot
```

## Configuration File Start

```
docker run -v /path/to/hubot.conf:/opt/hubot/hubot.conf -d hearstat/alpine-hubot
```

## Full Feature Start
Coming Soon

# Building
To build the image, do the following

```
docker build github.com/hearstat/docker-alpinehubot
```

A prebuilt container is available in the docker index.

```
docker pull hearstat/alpine-hubot
```

# Template files
## Hubot.Conf
Add all environment variables needed to conf file. See script repos for specific settings available.

The baseline config file in container only has ADAPTER/HUBOT_NAME set.

```
## Bot Settings
export ADAPTER='hipchat'
export HUBOT_NAME='hubot' # what hubot listens to

## Comma separated list of users who administer Hubot Auth
export HUBOT_AUTH_ADMIN="YourName"

## Hipchat adapter settings

# Credentials
export HUBOT_HIPCHAT_JID="JID@chat.hipchat.com"
export HUBOT_HIPCHAT_PASSWORD="SuperSecretPassword"

# Actual Rooms to join (JIDs)
export HUBOT_HIPCHAT_ROOMS="JID_RoomName@conf.hipchat.com"

# Set true/false to auto join rooms when mentioned/invited (true/false)
export HUBOT_HIPCHAT_JOIN_ROOMS_ON_INVITE="true"

# Explicitly refuse to join specified rooms (JIDs)
export HUBOT_HIPCHAT_ROOMS_BLACKLIST=""

# Auto reconnect attempt (true/false)
export HUBOT_HIPCHAT_RECONNECT="true"

# Set true/false for bot to join public rooms.
export HUBOT_HIPCHAT_JOIN_PUBLIC_ROOMS="false"
```
