#!/bin/bash
lng="ru"
colorset=("34" "" "" "24" "15" "1" "24" "15" "1")
########## Danger ###########################
#        Danger! Do not change the position 2 (second) line! (etc lng=*)
#        It is read in the flow!
########## Translate ########################
#        You can add your language using the same template

language_en=("English" "Git addAll/commit" "Git push" "Git create tag" "Git select proj" "Git init" "Git clone" "New Git project" "Options")
language_ru=("Русский" "Добавить все/коммит")

#####################################

lng="language_$lng[@]"; lng=("${!lng}")



colors() {
	
	
	if [[ "$1" == "set"  ]]; then
	
		clear
		let backgr=234
		let txts=34
		
	 	for col in {0..255}; do
	 		if (( "$col" == "0"  )); then col="256"; fi

	 		backgr=$col
	 		txts=$col
			if (( $col % 16 == 0 )); then echo -e "\n"; 		fi
			printf " \e[48;5;$backgr;38;5;$txts;22m%7s\e[0m" "$backgr;$txts"




done

		
		
		
		
		
								
			echo -e "\n\nExample: "
			echo -e "\r$(colors 'tm' "[$(date +"%T")]") $(colors 'pt' "${PWD%/*}"/)$(colors 'fl'  "$(basename   "$PWD")")"
			return
	fi
	
	if [[ "$1" == "tm"  ]]; then
		echo "\e[48;5;${colorset[0]};38;5;${colorset[1]};${colorset[2]}m$2\e[0m"
	elif [[ "$1" == "pt" ]]; then
		echo "\e[48;5;${colorset[3]};38;5;${colorset[4]};${colorset[5]}m$2\e[0m"
	elif [[ "$1" == "fl" ]]; then
		echo "\e[48;5;${colorset[6]};38;5;${colorset[7]};${colorset[8]}m$2\e[0m"
		

	fi
	
	
}


pwds() {


echo ""


colors set

	echo ---------
	
	for pw in {40..47}; do
		echo -en "\r\e[$pw;1m$PWD\e[0m"
		sleep 0.05 
	done 
	echo -e "\r$(colors 'tm' "[$(date +"%T")]") $(colors 'pt' "${PWD%/*}"/)$(colors 'fl'  "$(basename   "$PWD")")"

	 echo ---------
	

}




main() {
	menu0=("menu0" "${lng[1]};gitadd" "Git push;gitpush" "Git create tag;gittag" "Git select proj;gitselect" "Git init;gitinit" "Git clone;gitclone" "New Git project;gitnew")
	msg=""
	pwds

}

main
