Call of Duty 2 Server Launcher Script
===================================

A simple script to launch your Call of Duty 2 Server.

[Based on CSGO-Server-Launcher] (https://github.com/crazy-max/csgo-server-launcher)

Depends on GNU Screen and AWK.

Configuration
-------------

The config file is located in:

* **/path/to/installation/main/server.cfg**

Before running the script, you must change some variables.

* **SCREEN_NAME** - The screen name, you can put what you want but it must be unique and must contain only alphanumeric character.
* **USER** - Name of the user who started the server.
* **IP** - Your WAN IP address.
* **PORT** - The port that your server should listen on.
<br /><br />
* **DIR_GAME** - Path to the installation of the game.
* **DAEMON_GAME** - You don't normally need to change this variable.
* **LOG_NAME** - Name of the log file.
<br /><br />
* **DEDICATED** - It can be 0, 1 or 2. 0 for localhost, 1 for LAN, 2 for WAN operation
* **CFG_NAME** - Name of the cfg file.
* **CHEATS** - Enable of Disable cheats
* **MAX_CLIENTS** - Number of maximum clients.
* **PB** - Enable or Disable PunkBuster.
* **PUNKBUSTER** - Enable or Disable Punkbuster again with pb_sv_enable or pb_sv_disable.
* **PARAM_START** - Starting Parameters which depend on your previous choices take look if you need anything else.

GNU Screen should be configured in multiuser mode. [GNU Screen multiuser] (http://aperiodic.net/screen/multiuser)

Usage
-----

For the console mod, press CTRL+A then D to stop the screen without stopping the server.

* **start** - Start the server with the PARAM_START var in a screen.
* **stop** - Stop the server and close the screen loaded.
* **status** - Display the status of the server (screen down or up)
* **restart** - Restart the server (stop && start)
* **console** - Display the server console where you can enter commands.


Example of automatic restart with cron
--------------------------------------

You can automatically restart your game server by calling the script in a crontab.
Just add this line in your crontab and change the folder if necessary.

    0 5 * * * cd /path/to/script && ./cod2script restart >/dev/null 2>&1
	
This will update your server every day at 5 am.

