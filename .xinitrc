#! /bin/bash

xset +fp /usr/share/fonts/local
xset fp rehash

#Print Temperature of Zone
print_temp(){
        test -f /sys/class/thermal/thermal_zone0/temp || return 0
        echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}


#IP Address
print_ip () {
        ip address show
}

#Print Time and Date
print_date(){
        date "+%a %m-%d-%Y %T"
}


# DWM Bar loop
while true; do
   #Print above preset variables
   xsetroot -name "$(print_temp)  Battery:$(acpi | awk '{ print $4 }' |
tr -d ',')  $(print_date)"
   sleep 1s    # Update time every second
done &

# Autostart section
pcmanfm &

#StartDWM
xbindkeys
exec dwm

