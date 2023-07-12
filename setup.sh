#!/usr/bin/bash

# Edit the SSID and PASSPHRASE to connect to the internet
# Or pass it as arguments to the script

SSID=$1
PASSPHRASE=$2

# Don't edit anything after this

echo 'Setting up wifi for interface' $INTERFACE
echo 'ESSID' $SSID ' PASSPHRASE' $PASSPHRASE 

# Network manager needs to be disabled first
sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager

# create a wpa file with ssid and passphrase
# wpa_passphrase $SSID $PASSPHRASE | sudo tee /etc/wpa_supplicant.conf
echo -e "$(wpa_passphrase $SSID $PASSPHRASE | head -n 4)" "\n\tscan_ssid=1" "\n}" | sudo tee /etc/wpa_supplicant.conf

cat wifi.sh | sudo tee /usr/bin/wifi.sh
chmod +x /usr/bin/wifi.sh

# set up the service files
cat wpa_supplicant.service | sudo tee /etc/systemd/system/wpa_supplicant.service
cat dhclient.service | sudo tee /etc/systemd/system/dhclient.service

# enable the service files at boot
sudo systemctl enable dhclient.service
sudo systemctl enable wpa_supplicant.service

