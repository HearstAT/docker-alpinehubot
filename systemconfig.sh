#!/bin/bash

DIRECTORYLIST="/usr/local/bin /usr/bin /var/log/supervisor $HUBOT_HOME $HUBOT_HOME/scripts $HUBOT_HOME/node_modules $HUBOT_HOME/bin $HUBOT_HOME/.npm"

for dir in ${DIRECTORYLIST}; do
    mkdir -p ${dir} && chmod -R 777 ${dir}
done

HUBOTLIST="$HUBOT_HOME $HUBOT_HOME/scripts $HUBOT_HOME/node_modules $HUBOT_HOME/bin"

for botdir in ${HUBOTLIST}; do
    chown -R hubot:hubot ${botdir}
done
