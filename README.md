# Remote Debugginator

The Remote Debugginator is a portable Raspberry Pi system that enables remote LAN access through a 3g connection.

It was developed for the [Acacia Irrigation project](http://acaciairrigation.org/).

## Setup Digital Ocean server
Add this to `sudo nano /etc/ssh/sshd_config` so that the connection times out after 3 x 60 seconds of unresponsiveness.

    ClientAliveInterval 60

## Wifi network config

    sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
    
## Install & config screen

**Add this to `~/.screenrc`:**
    defshell -bash
    multiuser on
    acladd pi
  
## Setup startup scripts

This runs the `run.sh` script on the Pi's terminal when it boots up.

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

    
## SSH Config

Add to `~/.ssh/config` so that the client exits after error (usually it will hang) and disconnects after 3 x 60 seconds of unresponsiveness.

    ExitOnForwardFailure yes
    ServerAliveInterval 60

## Add the repo files to your home folder

    run.sh
    3g.sh
    tunnel.sh
    
    
    
## Links
Reverse tunneling errors: https://serverfault.com/questions/595323/ssh-remote-port-forwarding-failed

Look into this: https://mosh.mit.edu/#techinfo

    