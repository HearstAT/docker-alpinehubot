#!/bin/bash

echo "Initiating Dev Mode"

rm -f /etc/supervisord.d/*
mv ${HUBOT_HOME}/dev/supervisord.ini /etc/supervisor.d/supervisord.ini

cd ${HUBOT_HOME}
source ./config/hubot.conf

python script-install-dev.py

supervisord -n
