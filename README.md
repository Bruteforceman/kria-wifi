## Kria Wifi Setup


This script sets up the wifi dongle at interface wlx08beac12c548

First make sure you have `wpa_supplicant` installed. You can do so by running 

```
sudo apt install wpasupplicant
```

Then make the setup.sh script executable by running `chmod +x setup.sh`. Once you're done, you can simply run 

```
sudo ./setup.sh YOUR-SSID-NAME YOUR-PASSPHRASE
```

Once that runs to completion, you can test your internet connection by running `ping 8.8.8.8` or any other URL. You should also make sure you're connected to the desired network by checking the output from `iwconfig`

After this, you can run `reboot` and make sure you're connected to the network without automatically. 
