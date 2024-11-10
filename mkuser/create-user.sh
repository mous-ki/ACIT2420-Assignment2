#!/bin/bash

# Checks to see if user has root privileges, and prints a message if not
if [ $EUID -ne 0 ]; then
	echo "Please run this script as root."
	exit 1
fi

# Provides parsing options: username(-u), shell(-s), home directory(-h), groups(-g)
while getopts "u:s:h:g" opt; do
	case $opt in
		u) username=$OPTARG ;;
		s) shell=$OPTARG ;;
		h) home_dir=$OPTARG ;;
		g) groups=$OPTARG ;;
		*) echo "Usage: $0 -u username -s shell -h home_dir -g groups."; exit 1 ;;
	esac
done

# Checks required args
if [ -z $username || -z $shell || -z $home_dir ]; then
	echo "Error: -u(username), -s(shell) and -h (home_dir) are required."
	exit 1
fi

# Creates a group and user, with the shell and home directory specified
groupadd "$username"
useradd -m -d "$home_dir" -s "shell" -g "$username" "$username"

# Copies default files from /etc/skel to the user's home directory
cp -r /etc/skel/. "$home_dir/"

# Adds the user to any additional groups, if specified
[ -n $groups ] && usermod -aG "$groups" "$username"

# Sets a password for the user
echo "Set a password for $username:"
passwd "$username"

echo "New user $username has been created with shell $shell, home directory $home_dir and groups: $username,${groups:-none}."
