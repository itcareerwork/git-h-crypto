#!/bin/bash
langset=ru
colorset=("256" "34" "22" "24" "15" "1" "256" "226" "1")
########## Danger ###########################
#        Danger! Do not change the position 2 (second) line! (etc langset=*)
#        It is read in the flow!
########## Translate ########################
#        You can add your language using the same template


language_en=(	"English" 
		"Quit" 
		"Options" 
		"Main menu" 
		"Git add ALL files/commit" 
		"Git push" 
		"Git create tag" 
		"Git select proj" 
		"Git init" 
		"Git clone" 
		"New Git project" 
		"Change language"
		"Language selection"
		)
message_en=("English" "Select item" "Wrong! This item does not exist" "Repository not found\nPlease, select Git init pepository" "Added ALL files" "Enter you commit" "Changes recorded" "There is nothing to commit, no changes" "Select a language"  "The language has been changed to" "Start the program again")

language_ru=("Русский" "Выход" "Настройки" "Основное меню" "Git добавить ВСЕ файлы/коммит" "" "" "" "" "" "" "Изменить язык" "Выбор языка")
message_ru=("Русский" "Выберите пункт" "Неверно! Этого пункта не существует" "Репозиторий не найден\nПожалуйста, инициализируйте репозиторий, выбав Git init" "Добавление всех файлов" "Введите ваш коммит" "Изменения зарегистрированы" "Фиксировать нечего, изменений нет" "Выберите язык" "Язык изменен на" "Запустите программу заново")

#####################################



languages() {

	if [ "$1" == "set" ] ; then

		local lng_sfx=($(sed -r -n -e  "s/^\s?+language_(..).+/\1/p" "${0}"))
		local lng_menu=("${lng[12]};languages set")
		for a in ${lng_sfx[@]} ; do
			local d="language_$a[@]"; d=("${!d}")
			lng_menu+=("${d[0]};languages setmenu $a")
		done
		
		lng_menu+=("${lng[1]};exit")
		
		prints "lng_menu[@]" "${msg[8]}"
		
	fi
	
	
	
	if [ "$1" == "setmenu" ] ; then
		
		sed  -i -r "/^langset=/s/langset=[\"\']?$langset[\"\']?/langset=$2/" "${0}"
		local msg_oth="message_$2[@]"; msg_oth=("${!msg_oth}")
		
		colors "ok" "${msg[9]} ${msg_oth[0]}. ${msg[10]}" 
		colors "ok" "${msg_oth[9]} ${msg_oth[0]}. ${msg_oth[10]}"
		exit
	fi

	lng="language_$langset[@]"; lng=("${!lng}")
	msg="message_$langset[@]"; msg=("${!msg}")

	for b in ${!language_en[@]} ${!message_en[@]} ; do
	
		if [[ ! ${lng[$b]} ]] ; then
			lng[$b]=${language_en[$b]}
		fi
		if [[ ! ${msg[$b]} ]] ; then
			msg[$b]=${message_en[$b]}
		fi
	done
}

languages

colors() {
	
	
	if [[ "$1" == "set"  ]]; then
		local r_col=$(tput cols)
		local r_lin=$(tput lines)
		clear
		echo -e '\e[8;44;130t'		
		local backgr=234
		local txts=34

	 	for col in {1..256}; do

	 		backgr=$col
#	 		txts=$col
			if (( ($col - 1 ) % 16 == 0 )); then echo -e "\n"; 		fi
			printf " \e[48;5;$backgr;38;5;$txts;22m%7s\e[0m" "$backgr;$txts"
		done

		echo -e "\n\nExample: "
		echo -e "\r$(colors 'tm' "[$(date +"%T")]") $(colors 'pt' "${PWD%/*}"/)$(colors 'fl'  "$(basename   "$PWD")")"
			
		sleep 15
		tput clear



		echo -e "\e[8;${r_lin};${r_col}t"
					
		return
	fi
	
	if [[ "$1" == "tm"  ]]; then
		echo "\e[48;5;${colorset[0]};38;5;${colorset[1]};${colorset[2]}m$2\e[0m"
	elif [[ "$1" == "pt" ]]; then
		echo "\e[48;5;${colorset[3]};38;5;${colorset[4]};${colorset[5]}m$2\e[0m"
	elif [[ "$1" == "fl" ]]; then
		echo "\e[48;5;${colorset[6]};38;5;${colorset[7]};${colorset[8]}m$2\e[0m"
	elif [[ "$1" == "ok" ]]; then
		echo -e "\e[48;5;256;38;5;34;1m$2\e[0m"
	elif [[ "$1" == "err" ]]; then
		echo -e "\e[48;5;256;38;5;160;1m$2\e[0m"
	elif [[ "$1" == "title" ]]; then
		echo -e "\e[48;5;256;38;5;226;22m$2\e[0m"
	elif [[ "$1" == "item" ]]; then
		echo -e "\e[48;5;256;38;5;15;22m$2\e[0m"	
	

	fi
	
	
}



pwds() {
	echo ""
	echo ----------
	for pw in {40..47}; do
		echo -en "\r\e[$pw;1m$PWD\e[0m"
		sleep 0.05 
	done 
	echo -e "\r$(colors 'tm' "[$(date +"%T")]") $(colors 'pt' "${PWD%/*}"/)$(colors 'fl'  "$(basename   "$PWD")")"
	echo ----------
	

}

prints() {
	
	
	if [[ "$1" == "post" ]] ; then
		echo "$2" | cut -d ";" -f 1
		return
	elif [[ "$1" == "com" ]] ; then
		echo "$2" | cut -d ";" -f 2
		return
	fi
	
	pwds
	
	
	local menu=("${!1}")
	
	
	colors "title" "---$(prints "post" "${menu[0]}")---"
	for (( op=1; op < "${#menu[@]}"; op++ )); do 

		colors "item" "$op ) $(prints "post" "${menu[$op]}")"
	done
	echo ----------

	read -s -n1 -p "$(colors "item" "$2: ")" item	
	
	case $item in
		[1-$((${#menu[@]}-1))] ) colors "ok" "$item ) $(prints "post" "${menu[$item]}")"
		$(prints "com" "${menu[$item]}") ;;
		"q" ) echo; exit;;
		* ) colors "err" "[ $item ]->: ${msg[2]}"; sleep 2 ;;
	esac	
	


}

gitinit() {
	git init
}


gittest() {

	echo "test"

}



options() {

	local menu1=("${lng[2]};options" "${lng[11]};languages set" "${lng[1]};exit")
	prints "menu1[@]" "${msg[1]}"

}

err() {

	if [[ "$?" != "0" ]] ; then 
		colors "err" "$1" 
		sleep 1
		return 1 
	fi

}


gitadd() {
	git add .
	err "${msg[3]}" || return
	echo "${msg[4]} ..."
	git commit --porcelain 
	err "${msg[7]}" ||  return 
	 read -p "$(colors "item" "${msg[5]}: ")" comm
	 git commit -m "$comm"
	colors "ok" "${msg[6]}"
	
} 


main() {

	local menu0=("${lng[3]};main" "${lng[4]};gitadd" "${lng[8]};gitinit" "${lng[7]};gitselect" "${lng[2]};options" "${lng[1]};exit")
	
	while [ "$item" != "q" ] ; do 
		prints "menu0[@]" "${msg[1]}"
	done

}

main
