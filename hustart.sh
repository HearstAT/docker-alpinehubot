#!/bin/bash
# chkconfig: 2345 20 80
# description: Description comes here....

NAME="thebot"
USER='hubot'
GROUP='hubot'
HUBOT_HOME="/opt/hubot"
DAEMON="$HUBOT_HOME/bin/hubot"

# Source config if present
[ -r $BOT_PATH/hubot.conf ] && . $BOT_PATH/hubot.conf

hubot_pid() {
        echo `ps -fe | grep $BOT_PATH | grep -v grep | tr -s " "|cut -d" " -f2`
}

start() {
	pid=$(hubot_pid)
	if [ -n "$pid" ]:then
		echo -e "\e[00;31mHubot is already running (pid: $pid)\e[00m"
	else
		# Start Hubot
		echo -e "\e[00;32mStarting Hubot\e[00m"

		if [ `user_exists $HUBOT_USER` = "1" ]; then
			/bin/su $HUBOT_USER -c $DAEMON $DAEMONOPTS
		else
			echo -e "\e[00;31mHubot user $HUBOT_USER does not exists. Starting with $(id)\e[00m"
			sh $DAEMON $DAEMONOPTS
		fi

		status

	fi
	return 0
}

stop() {
	pid=$(hubot_pid)
  if [ -n "$pid" ]
  then
    echo -e "\e[00;31mStoping Hubot\e[00m"
		kill -9 $pid
  else
    echo -e "\e[00;31mHubot is not running\e[00m"
  fi

  return 0
}

case "$1" in
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart)
       stop
       start
       ;;
    status)
			pid=$(hubot_pid)
			if [ -n "$pid" ]
				then echo -e "\e[00;32mHubot is running with pid: $pid\e[00m"
			else
				echo -e "\e[00;31mHubot is not running\e[00m"
				return 3
			fi
	     ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0
