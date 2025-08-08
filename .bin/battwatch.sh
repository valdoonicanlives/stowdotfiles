#!/bin/bash

# Check if the battery is connected
if [ -e /sys/class/power_supply/BAT1 ]; then

    # this line is for debugging mostly. Could be removed
    #notify-send --icon=info "STARTED MONITORING BATERY"
    zenity --warning --text "STARTED MONITORING BATERY"

    while true;do   
            # Get the capacity
            CAPACITY=$( cat /sys/class/power_supply/BAT1/uevent | grep -i capacity | cut -d'=' -f2 )

            case $CAPACITY in
            # do stuff when we hit 20 % mark
            [0-9]|20)
                # send warning and suspend only if battery is discharging
                # i.e., no charger connected
                STATUS=$(  cat /sys/class/power_supply/BAT1/uevent | grep -i status | cut -d'=' -f2 )
                 if [ $(echo $STATUS) == "Discharging" ]; then

                    #notify-send --urgency=critical --icon=dialog-warning "LOW BATTERY! SUSPENDING IN 2 minutes"
                    yad --warning --text "LOW BATTERY! SUSPENDING IN 30 sec"
                    sleep 120
                    gnome-screensaver-command -l && sudo pm-suspend
                    break
                 fi
                ;;
            *)
            sleep 1
                continue
                ;;
            esac
    done
fi
