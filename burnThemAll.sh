#!/bin/bash

# BurnThemAll - A utility for burning CDs automatically
#    Copyright (C) 2026  Andrew Castillo

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


clear
echo "*****BurnThemAll.sh v1.0*****"
sleep 0.5
echo "BurnThemAll  Copyright (C) 2026  Andrew Castillo"
echo "This program comes with ABSOLUTELY NO WARRANTY; for details see menu."
echo "This is free software, and you are welcome to redistribute it under conditions located in the menu."
echo "Full notice available at https://www.gnu.org/licenses/#GPL"
cowsay -f daemon "press enter to continue"
read cont
clear
echo "*****BurnThemAll.sh v1.0*****"

# test if temp directory exists
if [ -d "./temp" ]; then
	echo "temp directory found"
else
	mkdir temp
	echo "making temp directory"
fi

# check if the user wants to burn songs or convert .mp3 files
clear
echo "*****BurnThemAll.sh v1.0*****"
cowsay -f daemon "What would you like to do?"
PS3="Select an option (1-3): "
select opt in "Burn CDs" "Convert Files" "Show License Information" "Exit" ; do
	case $opt in
		"Burn CDs")
			echo "We shall Burn CDs then..."
			sleep 1
			clear
			break
			;;
		"Convert Files")
			echo "We shall convert files then..."
			sleep 1
			clear
			break
			;;
		"Show License Information")
			echo "This program is distributed in the hope that it will be useful,"
			echo "but WITHOUT ANY WARRANTY; without even the implied warranty of"
			echo "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
			echo "GNU General Public License for more details."
			sleep 20
			exit
			break
			;;
		"Exit")
			echo "Goodbye"
			sleep 1
			exit
			break
			;;
		*)
			echo "Invalid option. Please enter a number (1-4)."
			;;
	esac
done

if [[ $opt == "Burn CDs" ]]; then
	if [ "$(ls -A temp)" ]; then
		echo "Songs found for burning"
		cd ./temp
		sleep 3
	else
		echo "Temp Directory is empty. Did you forget to load songs?"
		sleep 5
		exit
	fi

	clear
	echo "*****BurnThemAll.sh v1.0*****"
	echo "Burning .wav files from temp to drive"

	sleep 2
	# get the location of the CD burner
	clear
	echo "*****BurnThemAll.sh v1.0*****"

	echo "What is the location of the drive to burn to?"
	echo "(run wodim --devices for name, ctrl + c to exit)"
	read devname

	# do the burning

	wodim -eject -pad -tao -speed=16 dev=$devname -v -audio *.wav
else
	if [ "$(ls -A temp)" ]; then
		echo "Files found"
		echo "Converting Files"
		for file in ./temp/*; do
			if [ -f "$file" ]; then
				ffmpeg -i "$file" -b:a 192k -ar 44100 -ac 2 -sample_fmt s16 "$file.wav"
			fi
		done

		if [ -d "./backup" ]; then
			echo "backup directory found"
			mv ./temp/*.mp3 ./backup
		else
			mkdir temp
			echo "making temp directory"
			mkdir ./backup
			mv./temp/*.mp3 ./backup
		fi
	else
		echo "Files not found. Please place .mp3 files in temp directory"
		sleep 3
		exit
	fi
fi





