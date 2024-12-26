#!/bin/bash

if [ ! -f cfg.env ]; then
	echo "cfg.env file not found!"
	exit 1
fi


USR_DIR=$(echo $HOME | sed 's/\//\\\//g')

src=(
	"src/.vimrc"
	"src/.wezterm.lua"
	"src/.vimrc"
	"src/.nvim.lua"
)

dest=(
	"~/.vimrc"
	"~/.config/wezterm/wezterm.lua"
	"~/.config/nvim/init.vim"
	"~/.config/nvim/.nvim.lua"
)

for i in "${!src[@]}"; do
	f="${src[$i]}"
	o="${dest[$i]/#\~/$HOME}"
	mkdir -p $(dirname $o)
	tmp=$(mktemp)
	cp $f $tmp
	while IFS="=" read -r k v; do
		v=$(echo "$v" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
		v=$(printf '%s' "$v" | sed 's/[&/\]/\\&/g')
		sed "s/\${${k}}/${v}/g" "$tmp" > "${tmp}.new"
		mv "${tmp}.new" "$tmp"
	done < cfg.env
	
	sed "s/\${USR_DIR}/${USR_DIR}/g" "$tmp" > "${tmp}.new"
	mv "${tmp}.new" "$tmp"

	mv $tmp $o
done

cp ./src/bg.gif ~/.config/wezterm/bg.gif
