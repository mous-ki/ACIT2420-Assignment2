#!/bin/bash

# Function that creates a symbolic link with backup, IF the target exists
create_symlink() {
	src=$1
	dest=$2
	if [[ -e "$dest" ]]; then
		echo "Currently backing up existing file: $dest"
		mv "$dest" "$dest.bak"
	fi
	ln -s "$src" "$dest"
	echo "Successfully linked $src to $dest!"
}

# Links bin/ directory to ~/bin/ (home)
echo "Currently linking bin/ directory..."
create_symlink "$(pwd)/bin" "$HOME/bin"

# Links config/ directory to ~/.config/ (again, home)
echo "Currently linking config/ directory..."
create_symlink "$(pwd)/config" "$HOME/.config"

# Links bashrc file to ~/.bashrc
echo "Currently linking bashrc..."
create_symlink "$(pwd)/home/bashrc" "$HOME/.bashrc"

