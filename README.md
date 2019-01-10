# Remote Debugginator

The Remote Debugginator is a portable Raspberry Pi system that enables remote LAN access through a 3g connection.

It was developed for the [Acacia Irrigation project](http://acaciairrigation.org/).

## Parts List

* [Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
  * Make sure to buy a version 2 or higher, as it can [provide more power to USB devices](https://raspberrypi.stackexchange.com/questions/27708/is-setting-max-usb-current-1-to-give-more-power-to-usb-devices-a-bad-idea)
* [Power Supply](https://www.raspberrypi.org/products/raspberry-pi-universal-power-supply/), 2A or higher prefered. 
* [Case + Screen for RPi](http://www.amazon.com/Tontec%C2%AE-Raspberry-Display-Touchscreen-Transparent/dp/B00NANNJLQ/), Tontec 3.5 Inch Touch Screen used in testing. 
* [USB battery pack (10000 mAh)](http://www.amazon.com/Anker-10000mAh-Portable-External-Technology/dp/B009USAJCC/), or larger.
* 3g USB dongle
  * Here is a list of [Linux compatible dongles](http://elinux.org/RPi_VerifiedPeripherals#USB_3G_Dongles)
  * Make sure to [check for cell provider support](http://www.worldtimezone.com/gsm.html)
* [Portable USB keyboard](http://www.amazon.com/Rii-mini-X1-Raspberry-KP-810-10LL/dp/B00I5SW8MC/)
  * More options [Here](http://www.riitek.com/product/mini.html)
* [Digital Ocean instance](https://www.digitalocean.com/)
* M2M Sim card. Here are some providers:
  * [Podsystem M2M](http://www.podsystemm2m.com/)
  * [Embedded Works](http://www.embeddedworks.net/m2m-data.html)
  * [Neo by Aeris](http://neo.aeris.com/pricing/plans-pricing/)
  
## Raspberry Pi Setup

* The Pi was set up using the default [Raspbian distro](https://www.raspbian.org/), [Download Here](https://www.raspberrypi.org/downloads/raspbian/) desktop version for graphical interface. 
  * [Installation Guide](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
* Set up screen. See issue [#1](https://github.com/SEL-Columbia/remote-debugger/issues/1)
* [Connecting to wifi via command line](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)
* [Preventing Edimax wifi adapter from sleeping during shell sessions when idle](https://www.raspberrypi.org/forums/viewtopic.php?t=61665)
* [Booting directly into shell](http://stackoverflow.com/a/17830633)

[Booting up video](https://www.youtube.com/embed/kkuggWvZ5NY)

## Wifi network config

    sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

## Install & config screen

We run the 3g and tunnel shell scripts in separate <strong>screen</strong> windows. This makes it easier to debug should a problem occur.

* Install screen,

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install screen
```

**Add this to `~/.screenrc`:**

```
    defshell -bash
    multiuser on
    acladd pi
```

## Setup startup scripts

This runs the `run.sh` script on the Pi's terminal when it boots up.

**Add to `~/.bashrc`:**

```
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
```


## SSH Config

Add to `~/.ssh/config` so that the client exits after error (usually it will hang) and disconnects after 3 x 60 seconds of unresponsiveness.

```
    ExitOnForwardFailure yes
    ServerAliveInterval 60
```

Generate an SSH key on the Pi by following the [guide here](https://help.github.com/articles/generating-ssh-keys/). Then copy the Pi’s public key to `>~/.ssh/authorized_keys` on the DigitalOcean server. This will let the Pi login to the server without a password.

## Setup Digital Ocean server
Add this to `sudo nano /etc/ssh/sshd_config` so that the connection times out after 3 x 60 seconds of unresponsiveness.

    ClientAliveInterval 60

## Add the repo files to your home folder

```
    run.sh
    3g.sh
    tunnel.sh
```

## Max out RPi USB power settings

```
    sudo nano /boot/config.txt
```

and add,

```
    max_usb_current=1
```

to the bottom. Save and exit, then reboot.

## Setup 3G

To connect to 3g, we’ll need to install Sakis3g, now seemingly defunct. You cand still get it by instlling [UMTSKeeper](http://mintakaconciencia.net/squares/umtskeeper/). UMTSKeeper also helps by automatically reconnecting in the event of a connection failure. It’s a good idea to try UMTSKeeper first in interactive mode.

## Test Connection

Test out the reverse tunnel by running this command on the Pi. You’ll want to replace the IP address with the address of your own server.

```
ssh -R 22222:localhost:22 ubuntu@<IP Address>
```

If this works, you can log into your server (using a separate terminal) and connect to the Pi via this command:

```
ssh -p 22222 pi@localhost
```

## Links
Reverse tunneling errors: https://serverfault.com/questions/595323/ssh-remote-port-forwarding-failed

Look into this: https://mosh.mit.edu/#techinfo

How does reverse SSH tunneling work: https://unix.stackexchange.com/questions/46235/how-does-reverse-ssh-tunneling-work

https://blogs.wcode.org/2015/04/howto-ssh-to-your-iot-device-when-its-behind-a-firewall-or-on-a-3g-dongle/
