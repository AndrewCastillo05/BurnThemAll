#!/bin/bash

clear
echo "*****BurnThemAll.sh v1.0*****"
sleep 0.5
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
select opt in "Burn CDs" "Convert Files" "Exit"; do
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





