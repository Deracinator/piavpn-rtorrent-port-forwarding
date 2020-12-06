# THIS FILE IS CURRENTLY OUT-OF-DATE

# piavpn-rtorrent-port-forwarding
Port forwarding script for PiaVpn with rTorrent compatibilty 

NOTE: This script is already [distributed by PIA](https://privateinternetaccess.com/installer/port_forwarding.sh), this is a modified version of it that includes rTorrent compatibility by overwriting the port-range configuration to the port that will be passed to you by the PIA server every time a new port is called.

NOTE2: This script assumes that you're running it with the user that will run rTorrent, and that rTorrent is using the default configuration file location (.rtorrent.rc in your HOME directory).

## Installation and Usage

1. Connect to the VPN.

2. Run the following commands:

```bash
$ git clone https://github.com/Deracinator/piavpn-rtorrent-port-forwarding.git
$ cd piavpn-rtorrent-port-forwarding/
$ chmod +x port-forwarding.sh
$ ./port-forwarding.sh
```
3. Supposing everything went well, you will see (as an example, obviously):

```
Loading port forward assignment information...
Updating rTorrent port range...
{"port":56498}

```

4. And that's it!

---

Tested in archlinux on January/2020 with PIA on `openvpn`.
