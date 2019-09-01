#!/bin/bash

function ciao() {
	echo ""
	echo "Password manager for APiI"
	echo "(C) Ralf Ren <me@ralf.ren>. All rights reserved."
	echo ""
}

function help() {
	echo "usage: bash $0 [-s] [-v] [-h]"
	echo ""
	echo "  -h, --help      Show usage"
	echo "  -s, --set       Set password"
	echo "  -v, --verify    Verify password"
	echo ""
}

function setPassword() {
	read -sp 'Password: ' pass
	if [[ ! -n $pass ]]; then
		echo "No password specified."
		exit 0
	fi


	mkdir -p ~/.apii
	salt=$(cat /proc/sys/kernel/random/uuid | tr -d -)
	echo $salt > ~/.apii/salt

	hashs=$(md5sum <<< "${pass}+${salt}" | grep -oP ".*(?=\s)")
	echo $hashs > ~/.apii/hash

	echo "Hash: $hashs"
	echo "Salt: $salt"
}

function verifyPassword() {
	if [[ ! -d ~/.apii ]]; then
		echo "No password set yet."
		exit 0
	fi
	read -sp 'Password: ' pass
	if [[ ! -n $pass ]]; then
		echo "No password specified."
		exit 0
	fi


	salt=$(cat ~/.apii/salt)
	hashs=$(cat ~/.apii/hash)
	result=$(md5sum <<< "${pass}+${salt}" | grep -oP ".*(?=\s)")
	result=${result::-1}

	if [[ $result == $hashs ]]; then
		echo "true"
	else
		echo "false"
	fi
}

if [[ $# > 0 ]]; then
	key="$1"
	case $key in
		-s|--set)
			setPassword
			;;
		-v|--verify)
			verifyPassword
			;;
		-h|--help)
			help
			;;
	esac
else
	ciao
	help
fi
