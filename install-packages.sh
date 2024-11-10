#!/bin/bash

# Checks if script is being run as root - if not, print error message
if [[ $EUID -ne 0]]; then
	echo "Error: please run as root" >&2
	exit 1
fi

# Checks to see if packages.txt (user-defined list) exists
if [[ ! -f "packages.txt" ]]; then
	echo "Error: packages.txt file wasn't found. Please create it with the list of packages to be installed." >&2
	exit 1
fi

# Reads and installs each package listed in packages.txt file
echo "Installing packages from packages.txt..."
while read -r package; do
	if ! pacman -S --noconfirm "$package"; then
		echo "Failed to install $package" >&2
	else 
		echo "Successfully installed $package!"
	fi
done < packages.txt
