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


pwds() {
	echo ""
	echo ---------
	echo -e "\[\e[5m $PWD \e[0m"
	echo ---------
}


main() {
	menu0=("menu0" "${lng[1]};gitadd" "Git push;gitpush" "Git create tag;gittag" "Git select proj;gitselect" "Git init;gitinit" "Git clone;gitclone" "New Git project;gitnew")
	msg=""
	pwds

}

main
