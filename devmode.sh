#!/bin/bash

echo "Initiating Dev Mode"

rm -f /etc/supervisord.d/*
mv ${HUBOT_HOME}/dev/supervisord.ini /etc/supervisor.d/supervisord.ini

export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"

cd ${HUBOT_HOME}
source ./config/hubot.conf

python script-install.py

supervisord -n
