# hearstat/alpine-hubot
Hubot running on [Alpine](https://hub.docker.com/_/alpine/) with the [Hipchat Adapter](https://github.com/hipchat/hubot-hipchat).

# Build Info
## NODE
- NodeJS: 4.12
- NPM: 2.24.9

## Default Scripts
- [hubot-hipchat](https://github.com/hipchat/hubot-hipchat)
- [hubot-diagnostics]()
- [hubot-help]()
- [hubot-google-images]()
- [hubot-pugme]()
- [hubot-maps]()
- [hubot-redis-brain](https://github.com/github/hubot-scripts/blob/master/src/scripts/redis-brain.coffee)
- [hubot-rules]()
- [hubot-shipit](https://github.com/github/hubot-scripts/blob/master/src/scripts/shipit.coffee)
- [hubot-pager-me](https://github.com/hubot-scripts/hubot-pager-me)
- [hubot-plusplus](https://github.com/hubot-scripts/hubot-plusplus)
- [hubot-reload-scripts](https://github.com/vinta/hubot-reload-scripts)
- [hubot-leankit](https://github.com/battlemidget/hubot-leankit)

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

Mount the config directory to manage credentials/settings outside of container
- /opt/hubot/config

Mount the scripts directory to manage any non-npm installs/simple scripts
- /opt/hubot/scripts

Mount the external-scripts for control
- /opt/hubot/external-scripts.json

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
docker run -v /path/to/hubot.conf:/opt/hubot/config/hubot.conf -d hearstat/alpine-hubot
```

## Full Feature Start

```
docker run -v /path/to/hubot.conf:/opt/hubot/config/hubot.conf \
-v /path/to/redis/save:/var/lib/redis \
-v /path/to/external-scripts.json:/opt/hubot/external-scripts.json \
-d hearstat/alpine-hubot
```
## Dev Mode Start
I've setup this bot to be able to switch back and forth from Hipchat to Shell via startup commands. This is how to get into "Dev Mode" or enable the shell adapter.
```
docker run -d hearstat/alpine-hubot /usr/bin/devmode
```
then just do the following to connect to the container at the shell level
```
docker exec -it $container_name bash
```
then once in run the following
```
./bin/hubot
```
Then you can interact with hubot at the shell level

## Prod Mode Start
To switch back to hipchat or "Prod Mode" do the following
```
docker exec $container_name /usr/bin/prodmode
```
or just run a new container

# Run Time Help
Since this container comes with a bot reload option, edit the external-scripts.json as needed and run the following

```
docker exec $container_name python script-install.py
```
Note: you can just restart the container, it will re-run the same script before loading the bot.

Then in chat tell hubot to reload (my default is thebot)

```
@hubot reload
```

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
Lives at /opt/hubot/config and is sourced at run time.

Add all environment variables needed to conf file. See script repos for specific settings available.

The baseline config file in container only has ADAPTER/HUBOT_NAME set.

```
## Bot Settings
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

## external-scripts.json
The embedded script-install.py utilizes the external-scripts.json for it's install items, I did this to simplify the process. You already have to add everything to the file regardless, so use it to install from.

```
[
  "hubot-diagnostics",
  "hubot-help",
  "hubot-google-images",
  "hubot-pugme",
  "hubot-maps",
  "hubot-redis-brain",
  "hubot-rules",
  "hubot-shipit",
  "hubot-pager-me",
  "hubot-plusplus",
  "hubot-reload-scripts",
  "hubot-leankit"
]
```
