#!/bin/bash
langset=ru
colorset=("256" "34" "22" "24" "15" "1" "256" "226" "1")
########## Danger ###########################
#        Danger! Do not change the position 2 (second) line! (etc langset=*)
#        It is read in the flow!
########## Translate ########################
#        You can add your language using the same template


language_en=("English" "Quit" "Git add ALL files/commit" "Git push" "Git create tag" "Git select proj" "Git init" "Git clone" "New Git project" "Options")
message_en=("English" "Select item" "Wrong! This item does not exist")

language_ru=("Русский" "Выход" "Git добавить ВСЕ файлы/коммит")
message_ru=("Русский" "Выберите пункт" "Неверно! Этого пункта не существует")

#####################################

lng="language_$langset[@]"; lng=("${!lng}")
msg="message_$langset[@]"; msg=("${!msg}")

for lnglang in ${!language_en[@]} ${!message_en[@]} ; do
	if [[ ! ${lng[$lnglang]} ]] ; then
		lng[$lnglang]=${language_en[$lnglang]}
	fi
	if [[ ! ${msg[$lnglang]} ]] ; then
		msg[$lnglang]=${message_en[$lnglang]}
	fi
done

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
			
		sleep 50
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
	
	
	if [[ "$1" == "msg" ]] ; then
		echo "$2" | cut -d ";" -f 1
		return
	elif [[ "$1" == "com" ]] ; then
		echo "$2" | cut -d ";" -f 2
		return
	fi
	
	pwds
	
	
	local menu=("${!1}")
	
	echo 
	for (( op=1; op < "${#menu[@]}"; op++ )); do 

		echo "$op )" "${menu[$op]}" | cut -d ";" -f 1
	done
	echo ----------

}

gitpush() {
	echo "You select git Push"

}


main() {
	menu0=( "menu0" "${lng[1]};exit")


	while [ "$item" != "q" ] ; do 
	prints "menu0[@]"

			
	read -s -n1 -p "${msg[1]}: " item	

	case $item in
		[1-$((${#menu0[@]}-1))] ) colors "ok" "$item ) $(prints "msg" "${menu0[$item]}")"
		$(prints "com" "${menu0[$item]}") ;;
		"q" ) echo; exit;;
		* ) colors "err" "[ $item ]->: ${msg[2]}"; sleep 2 ;;
	esac	
	
	
	done

}

main
