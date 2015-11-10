#!/bin/bash

echo "Initiating Prod Mode"

rm -f /etc/supervisord.d/*
mv ${HUBOT_HOME}/prod/supervisord.ini /etc/supervisor.d/supervisord.ini

cd ${HUBOT_HOME}

supervisord -n
