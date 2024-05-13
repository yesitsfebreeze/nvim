#!/bin/bash

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

brew install go
brew install ripgrep
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
brew install nvim
brew install tmux 
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions

if ! gem list -i "colorls" > /dev/null 2>&1; then
  sudo gem install colorls
fi

mkdir -p ~/.config/nvim

if [[ -d ~/.config/nvim/.git ]]; then
  cd ~/.config/nvim && git pull
else
  git clone https://github.com/yesitsfebreeze/nvim ~/.config/nvim 
fi
