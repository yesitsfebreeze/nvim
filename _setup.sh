#!/bin/bash

src=(
	"src/.vimrc"
	"src/.wezterm.lua"
	"src/.env"
	"src/.sessions.lua"
	"src/.vimrc"
	"src/.nvim.lua"
	"src/.env"
	
)

dest=(
	"~/.vimrc"
	"~/.config/wezterm/wezterm.lua"
	"~/.config/wezterm/.env"
	"~/.config/wezterm/sessions.lua"
	"~/.config/nvim/init.vim"
	"~/.config/nvim/.nvim.lua"
	"~/.config/nvim/.env"
)

for i in "${!src[@]}"; do
	f="${src[$i]}"
	o="${dest[$i]/#\~/$HOME}"
	cp $f $o
done

cp -R ./src/img/. ~/.config/wezterm