#!/bin/sh

# This assumes you have:
# 1) A user called `root` in charge of the bot. (Can easily be changed in the variables below)
# 2) A file called /opt/hubot/hubot.conf that contains the Hubot credentials.
#
# To set the adapter either edit bin/hubot to specify what you want or append
# `-- -a campfire` to the $DAEMON variable below.
#
### BEGIN INIT INFO
# Provides:          hubot
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the hubot service
# Description:       starts the Hubot bot for hipchat
### END INIT INFO

NAME="Hubot"
USER='hubot'
GROUP='hubot'
SCRIPTNAME='hubot-init'
DAEMON_OPTS='--adapter hipchat --name thebot'
HUBOT_HOME="/opt/hubot"
LOGFILE="/var/log/hubot/hubot.log"
PIDFILE="/var/run/hubot.pid"
DAEMON="$HUBOT_HOME/bin/hubot"
PATH=${PATH}:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$HUBOT_HOME

# If config is present, source.
[ -r $BOT_PATH/hubot.conf ] && . $BOT_PATH/hubot.conf

set -e

case "$1" in
  start)
        echo -n "Starting $NAME: "
        start-stop-daemon --start --quiet --pidfile $PIDFILE -c $USER:$GROUP --make-pidfile --background --exec $DAEMON $DAEMON_OPTS
        echo "."
        ;;
  stop)
        echo -n "Stopping $NAME: "
        start-stop-daemon --stop --quiet --pidfile $PIDFILE
        echo "."
        ;;

   restart)
        echo -n "Restarting $NAME: "
        start-stop-daemon --stop --quiet --pidfile $PIDFILE
        start-stop-daemon --start --quiet --pidfile $PIDFILE -c $USER:$GROUP --make-pidfile --background --exec $DAEMONA $DAEMON_OPTS
        echo "."
        ;;

    *)
        echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
        exit 1
        ;;
    esac
    exit
