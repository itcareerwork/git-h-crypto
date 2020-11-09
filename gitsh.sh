#!/bin/bash
lng="ru"

########## Danger ###########################
#        Danger! Do not change the position 2 (second) line! (etc lng=*)
#        It is read in the flow!
########## Translate ########################
#        You can add your language using the same template

language_en=("English" "Git addAll/commit" "Git push" "Git create tag" "Git select proj" "Git init" "Git clone" "New Git project" "Options")
language_ru=("Русский" "Добавить все/коммит")

#####################################

lng="language_$lng[@]"; lng=("${!lng}")

#&& sleep 2

colors() {
	
	clear
	let backgr=16
	let txts=15
 	for backgr in {0..255}; do
		if (( $backgr % 16 == 0 )); then 
			echo -e ""
		fi

		if (( "$backgr" < 10 )); then
			echo -en " \e[38;5;$txts;48;5;$backgr;1m$txts;$backgr\e[0m"
		elif (( "$backgr" < 100 )); then
			echo -en " \e[38;5;$txts;48;5;$backgr;1m$txts;$backgr\e[0m"
		else
			echo -en " \e[38;5;$txts;48;5;$backgr;1m$txts;$backgr\e[0m"
		fi

		(( i++ ))
	 done
echo
expr length "$txts;$backgr"
}


pwds() {

echo ""



	echo ---------

	echo -en "$PWD"
	sleep 0.1  
	echo -en "\r\e[2K\e[7m$PWD"
	sleep 0.1 
	echo -en "\r\e[2K\e[27m$PWD"
	sleep 0.1 
	echo -en "\r\e[2K\e[7m$PWD"
	sleep 0.1 
	echo -en  "\r\e[2K\e[27m$PWD"
	sleep 0.1 
	echo -en "\r\e[0K\e[32m[$(date +"%T")]\e[0;1m"
	echo -e  "\e[48;5;24;38;5;15m${PWD%/*}/\e[0;1;33m$(basename "$PWD")\e[0m"

	

	 echo ---------
colors

# 23,24,65,66,71,101,102

}
#rc=E8,:  восстановление позиции курсора

#sc=E7,:  сохранение положения курсора##

main() {
	menu0=("menu0" "${lng[1]};gitadd" "Git push;gitpush" "Git create tag;gittag" "Git select proj;gitselect" "Git init;gitinit" "Git clone;gitclone" "New Git project;gitnew")
	msg=""
	pwds

}

main
