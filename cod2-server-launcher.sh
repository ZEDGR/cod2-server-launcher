#!/bin/bash

##################################################################################
#                                                                                #
#  Call of Duty 2 Launcher script                                                #
#                                                                                #
#  Author: Cr@zy, ZED                                                            #
#  Contact: georlema@gmail.com                                                   #
#                                                                                #
#  This program is free software: you can redistribute it and/or modify it       #
#  under the terms of the GNU General Public License as published by the Free    #
#  Software Foundation, either version 3 of the License, or (at your option)     #
#  any later version.                                                            #
#                                                                                #
#  This program is distributed in the hope that it will be useful, but WITHOUT   #
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS #
#  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more         #
#  details.                                                                      #
#                                                                                #
#  You should have received a copy of the GNU General Public License along       #
#  with this program.  If not, see http://www.gnu.org/licenses/.                 #
#                                                                                #
#  Usage: ./codscript {start|stop|status|restart|console}                        #
#    - start: start the server                                                   #
#    - stop: stop the server                                                     #
#    - status: display the status of the server (down or up)                     #
#    - restart: restart the server                                               #
#    - console: display the server console where you can enter commands.         #
#     To exit the console without stopping the server, press CTRL + A then D.    #
#                                                                                #
##################################################################################

SCREEN_NAME="cod2server"
USER="coduser"
IP="1.2.3.4"
PORT="28960"


DEDICATED="2"
CHEATS="0"
CFG_NAME="server.cfg"
MAX_CLIENTS="20"
PB="0"
PUNKBUSTER="pb_sv_disable"


DIR_GAME="path/to/folder"
DAEMON_GAME="cod2_lnxded"

LOG_NAME="`date +%Y%m%d`.log"

PARAM_START="+set dedicated $DEDICATED +safe +set net_ip $IP +set net_port $PORT $PUNKBUSTER +set sv_punkbuster $PB +set sv_maxclients $MAX_CLIENTS +set sv_cheats $CHEATS +set g_log $LOG_NAME +exec $CFG_NAME +map_rotate"

if [ ! -x `which awk` ]; then echo "ERROR: You need awk for this script (try install awk)"; exit 1; fi
if [ ! -x `which screen` ]; then echo "ERROR: You need screen for this script (try install screen)"; exit 1; fi

function start {
  if [ ! -d $DIR_GAME ]; then echo "ERROR: $DIR_GAME is not a directory"; exit 1; fi
  if [ ! -x $DIR_GAME/$DAEMON_GAME ]; then echo "ERROR: $DIR_GAME/$DAEMON_GAME does not exist or is not executable"; exit 1; fi
  if status; then echo "$SCREEN_NAME is already running"; exit 1; fi

  if [ `whoami` = root ];
  then
    su - $USER -c "cd $DIR_GAME ; screen -AmdS $SCREEN_NAME ./$DAEMON_GAME $PARAM_START"
  else
    cd $DIR_GAME ; screen -AmdS $SCREEN_NAME ./$DAEMON_GAME $PARAM_START
  fi
}

function stop {
  if ! status; then echo "$SCREEN_NAME could not be found. Probably not running."; exit 1; fi

  if [ `whoami` = root ];
  then
    tmp=$(su - $USER -c "screen -ls" | awk -F . "/\.$SCREEN_NAME\t/ {print $1}" | awk '{print $1}')
    su - $USER -c "screen -r $tmp -X quit"
  else
    screen -r $(screen -ls | awk -F . "/\.$SCREEN_NAME\t/ {print $1}" | awk '{print $1}') -X quit
  fi
}

function status {
  if [ `whoami` = root ];
  then
    su - $USER -c "screen -ls" | grep [.]$SCREEN_NAME[[:space:]] > /dev/null
  else
    screen -ls | grep [.]$SCREEN_NAME[[:space:]] > /dev/null
  fi
}

function console {
  if ! status; then echo "$SCREEN_NAME could not be found. Probably not running."; exit 1; fi
  screen -r $USER/$(screen -ls | awk -F . "/\.$SCREEN_NAME\t/ {print $1}" | awk '{print $1}')
}

function usage {
  echo "Usage: $0 {start|stop|status|restart|console}"
  echo "On console, press CTRL+A then D to stop the screen without stopping the server."
}

case "$1" in

  start)
    echo "Starting $SCREEN_NAME..."
    start
	sleep 5
    echo "$SCREEN_NAME started successfully"
  ;;

  stop)
    echo "Stopping $SCREEN_NAME..."
    stop
	sleep 5
    echo "$SCREEN_NAME stopped successfully"
  ;;
 
  restart)
    echo "Restarting $SCREEN_NAME..."
    status && stop
	sleep 5
    start
	sleep 5
	echo "$SCREEN_NAME restarted successfully"
  ;;

  status)
    if status
    then echo "$SCREEN_NAME is UP" 
    else echo "$SCREEN_NAME is DOWN"
    fi
  ;;
 
  console)
	echo "Opening console on $SCREEN_NAME..."
    console
  ;;

  *)
    usage
	exit 1
  ;;

esac

exit 0


