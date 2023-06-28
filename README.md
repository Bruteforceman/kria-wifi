## Kria Wifi Setup

This script sets up the wifi dongle for kria-boards. 

First make sure you have `wpa_supplicant` installed. You can do so by running 

```
sudo apt install wpasupplicant
```

Then make the setup.sh script executable by running `chmod +x setup.sh`. Once you're done, you can simply run 

```
sudo ./setup.sh YOUR-SSID-NAME YOUR-PASSPHRASE
```

Once that runs to completion, you can test your internet connection by running `ping 8.8.8.8`. You should also make sure you're connected to the desired network by checking the output from `iwconfig`. Note that sometimes you may not be able to resolve DNS immediately (so `ping www.google.com` may not immediately work). But it should work after you reboot.

After this, you can run `reboot` and make sure you're connected to the network automatically. 

**Note:** If your ESSID or PASSPHRASE contains spaces or other terminal characters, you cannot pass them as arguments to the setup script. You should assign the variables directly instead inside the `setup.sh` script. For example, if your SSID is `wifi net1` and passphrase is `123456789`, then inside the SSID script, you should edit the variables `SSID` and `PASSPHRASE` such that 

```
SSID="wifi net1"
PASSPHRASE="123456789"
```  
