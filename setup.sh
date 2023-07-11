#!/usr/bin/bash

# Edit the SSID and PASSPHRASE to connect to the internet
# Or pass it as arguments to the script

SSID=$1
PASSPHRASE=$2

export INTERFACE=$(ifconfig | awk '$1 ~ /^wl/ {print $1}' | rev | cut -c 2- | rev)

if [ -z "$INTERFACE" ]
then
	echo 'No valid interface found. Please insert a wifi dongle or manually assign the INTERFACE variable in the script'
	exit
fi

echo 'Interface found' $INTERFACE


# Don't edit anything after this

echo 'Setting up wifi for interface' $INTERFACE
echo 'ESSID' $SSID ' PASSPHRASE' $PASSPHRASE 

# Network manager needs to be disabled first
sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager

# create a wpa file with ssid and passphrase
# wpa_passphrase $SSID $PASSPHRASE | sudo tee /etc/wpa_supplicant.conf
echo -e "$(wpa_passphrase $SSID $PASSPHRASE | head -n 4)" "\n\tscan_ssid=1" "\n}" | sudo tee /etc/wpa_supplicant.conf

# connect to the wifi via wpa_supplicant
sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i $INTERFACE

# get an ip address
sudo dhclient $INTERFACE

# set up the service files
envsubst < wpa_supplicant.service | sudo tee /etc/systemd/system/wpa_supplicant.service
envsubst < dhclient.service | sudo tee /etc/systemd/system/dhclient.service

# enable the service files at boot
sudo systemctl enable dhclient.service
sudo systemctl enable wpa_supplicant.service

