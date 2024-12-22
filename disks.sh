#!/bin/bash

disk_options=()

for disk in $(lsblk -dno NAME,TYPE | awk '$2 == "disk" {print $1}'); do 
  disk_options+=("$disk" "/dev/$disk" "off")
done

selected_disk=$(dialog --radiolist "Select a Disk" 15 40 4 "${disk_options[@]}" 2>&1 >/dev/tty)

return_code=$?
clear 
if [ $return_code -ne 0 ]; then
  echo "Nie wybrałeś żadnego dysku :("
  exit 1
fi

partition_options=()
for partition in $(lsblk -nrpo NAME,TYPE /dev/"$selected_disk" | awk '$2 == "part" {print $1}'); do 
  partition_options+=("$partition" "$partition" "off")
done

selected_partitions=$(dialog --checklist "Select partition(s) on /dev/$selected_disk" 15 50 8 "${partition_options[@]}" 2>&1 >/dev/tty)

return_code=$?
clear

if [ $return_code -ne 0 ]; then
  echo "Nie wybrałeś partycji albo dysk ich nie ma :("
  exit 1
fi

echo "Wybrany Dysky: /dev/$selected_disk"
echo "Wybrane Partycje: $selected_partitions"

timestamp=$(date +"%Y%m%d-%H%M%S")
filename="Raport_${timestamp}.txt"
available_disks=$(lsblk -o NAME,SIZE,TYPE | grep disk)

echo "Raport z dnia ${timestamp} ze stanu dysków" > $filename
echo " " >> $filename
echo "Dostępne dyski:" >> $filename
echo "$available_disks" >> $filename
echo " " >> $filename

IFS=' ' read -r -a selected_partitions_array <<< "$selected_partitions"

for partition in "${selected_partitions_array[@]}"; do
  echo "Stan użycia dla $partition:" >> $filename 
  df -h "$partition" >> $filename
  echo "--------------------------" >> $filename
done


echo "Plik o nazwie $filename został zapisany w $(pwd)."
