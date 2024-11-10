#!/bin/bash

# Function for usage
usage() {
	echo "Usage: $0 [-i] [-l]"
	echo " -i   Install packages from .txt"
	echo " -l   Link configuration files"
	exit 1
}


# Parses options
while getopts "il" option; do
	case $option in 
		i) install_packages=1 ;;
		l) link_files=1 ;;
		*) usage ;;
	esac
done

# Runs the install-packges script if -i option is chosen
if [ $install_packages -eq 1 ]; then
	./install-packages.sh
fi

# Runs the link-configs script if -l option is chosen
if [ $link_files -eq 1 ]; then
	./link-configs.sh
fi

# If no option is chosen, display usage
if [ -z $install_packages && -z $link_files ]; then
	usage
fi
