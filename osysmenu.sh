#!/bin/bash

while

CHOICE=$(dialog --clear \
--backtitle "OSYS1000 Menu" \
--title "Main Menu" \
-- menu "Choose One of the following options" \
15 40 4 \
1 "Where am I" 2 "Directory Details" 3 "Text Editor" 4 "Exit" \
2>&1 >/dev/tty)

do

case $CHOICE in
1) clear; /
dialog --title "Current Directory" --msgbox `pwd` 6 20 ;;

2) clear; / 
dialog --title "Directory Details" --inoutbox "Enter path" 6 30 2>/tmp/input.txt; /
input=$(cat /tmp/input.txt); /
owner=$(stat -c "%U" $input); /
perm=$(stat -c "%A%" $input); /
count=$(ls $input | wc -1); /
large=$(du -a $input/* | sort -nr | head -n 1)
dialog --title "Owner" --msgbox "Directory is: $input \n Owner is: $owner \n Permissions are: $perm \n Number of files: $count \n Largest file: $large" 15 35 ;;

3) vim;;

4) break;;

esac

done

