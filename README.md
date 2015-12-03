# Remote Debugginator

The Remote Debugginator is a portable Raspberry Pi system that enables remote LAN access through a 3g connection.

It was developed for the [Acacia Irrigation project](http://acaciairrigation.org/).


## Wifi network config

    sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
  
## Install & config screen

**Add this to `~/.screenrc`:**
    defshell -bash
    multiuser on
    acladd pi
  
## Setup startup scripts

**Add to `~/.bashrc`:**
    if [ -n "$STY" ]; then
        # Screen session
        echo 'screen session'
    elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        # SSH Session
        # http://serverfault.com/a/506267
        echo 'ssh session'
    else
        # Main session
        echo 'main session'
        ~/run.sh
    fi
    
## Add to ~/.ssh/config

    ExitOnForwardFailure yes
    ServerAliveInterval 60
    ServerAliveCountMax 3

## Add the repo files to your home folder

    run.sh
    start-3g.sh
    start-tunnel.sh
    

    