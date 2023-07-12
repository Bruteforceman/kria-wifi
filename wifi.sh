#!/usr/bin/bash

sudo /sbin/wpa_supplicant -u -s -c /etc/wpa_supplicant.conf -i "$(ifconfig | awk '$1 ~ /^wl/ {print $1}' | rev | cut -c 2- | rev)"
