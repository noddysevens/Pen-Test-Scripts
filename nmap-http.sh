#!/bin/bash

if [ "$#" != "1" ]; then
	echo "Nmap FTP: A Tool to automate Nmap FTP scripts by David Gillett"
	echo " " 
	echo "Usage: nmap-http <ip address>"
	echo "Example: nmap-http 10.10.10.191"
	echo " "
	exit 1

else
	total_scripts=$(ls /usr/share/nmap/scripts | grep http | wc -l)
	scripts=$(ls /usr/share/nmap/scripts | grep http)
	script_count=0
	file_names=$(ls /usr/share/nmap/scripts/ | grep http | sed s/http-//g | sed s/.nse//g)

	function ProgressBar {
		let _progress=(${script_count}*100/${total_scripts}*100)/100
		let _done=(${_progress}*4)/10
		let _left=40-$_done

		_fill=$(printf "%${_done}s")
		_empty=$(printf "%${_left}s")

	printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"
	
	}
	
	for script in $scripts:
		do
		nmap -T4 -p80 -oA "script_${script_count}" --script="${script}" "$1"

		((++script_count))
		ProgressBar ${number} ${total_scripts}

	done

fi

exit 0
