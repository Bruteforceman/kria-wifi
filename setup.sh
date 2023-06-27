#!/usr/bin/bash


INTERFACE="wlx08beac12c548"

echo 'Setting up wifi for interface ' $INTERFACE

# Network manager needs to be disabled first
sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager

# create a wpa file with ssid and passphrase
wpa_passphrase $1 $2 | sudo tee /etc/wpa_supplicant.conf

# get an ip address
sudo dhclient $INTERFACE -r

# set up the service files
sudo cp wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service
sudo cp dhclient.service /etc/systemd/system/dhclient.service

# enable the service files at boot
sudo systemctl enable dhclient.service
sudo systemctl enable wpa_supplicant.service

