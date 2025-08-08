#!/bin/bash

#Declare colors
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

wifictl(){
    case $1 in
    connect)
    bssid="$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | dmenu -l 10 -p "Select Wifi  :" | cut -d ' ' -f1)"

    pass=$(echo "" | dmenu -l 2 -p "Enter Password  :")

    [ -z "$bssid" ] && exit 0 || [ -n "$pass" ] && nmcli device wifi connect "$bssid" password "$pass" || nmcli device wifi connect "$bssid"
    ;;

    disconnect)
    nmcli device disconnect wlan0
    ;;

    *)
    printf ${red}"invalid argument: ${nc} $1 \n"
    printf ${yellow}"valid arguments are:\n"
    printf "connect\n"
    printf "disconnect${nc}\n" && exit 1
    ;;
esac
}
wifictl $1
