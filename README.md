CS:GO Server Installer/Launcher v2
==================================

A simple script to install & launch your Counter-Strike : Global Offensive Dedicated Server.

Configuration
-------------

The config file is located in:

* **/etc/steam/csgo.conf**

Usage
-----

For the console mod, press CTRL+A then D to stop the screen without stopping the server.

* **install** - Install the server.
* **start** - Start the server with the PARAM_START var in a screen.
* **stop** - Stop the server and close the screen loaded.
* **status** - Display the status of the server (screen down or up)
* **restart** - Restart the server (stop && start)
* **console** - Display the server console where you can enter commands.
* **update** - Update the server based on the SCRIPT_UPDATE file then save the log file in LOG_DIR and send an e-mail.

Automatic update with cron
--------------------------

You can automatically update your game server by calling the script in a crontab.
Just add this line in your crontab and change the folder if necessary.

    0 4 * * * cd /usr/share/steamcmd/ && STEAM_USER="username-here" STEAM_PASS="password-here" ./csgo update >/dev/null 2>&1
	
This will update your server every day at 4 am.

