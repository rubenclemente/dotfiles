#!/usr/bin/env bash


GITHUB_USER="rubenclemente"
USER_EMAIL="rubenclemente@gmail.com"
USER_NAME="Rubén Clemente"

DOTFILE_DIR=~/dotfiles
DOTFILE_BACKUP_DIR=~/dotfiles-backup


function install-git() {
  if ! [ -x "$(command -v git)" ]; then
    if [ -x "$(command -v apt)" ]; then
      sudo apt update
      sudo apt install git -y
    fi
    if ! [ -x "$(command -v git)" ]; then
      printf "\nThis script requires git!\n"
      exit 1
    fi
  fi
}

function configure-git() {
  git config --list

  #echo "Enter Git fullname:"
  #read USER_NAME
  echo "Requesting root permissions to set git config at system level..."
  sudo git config --system user.name $USER_NAME
  echo "Success."

  #echo "Enter Git email address:"
  #read USER_EMAIL
  echo "Requesting root permissions to set git config at system level..."
  sudo git config --system user.email $USER_EMAIL
  echo "Success."

  git config --list
}

function create-symlink() {
  if [ -e ~/$1 ]; then
    echo "Found existing file, creating backup: $DOTFILE_BACKUP_DIR/$1.bak"
    echo "> mv ~/$1 $DOTFILE_BACKUP_DIR/$1.bak"
    mv ~/$1 $DOTFILE_BACKUP_DIR/$1.bak
  fi
  echo "Creating syslink: ~/$1"
  echo "> ln -sf $DOTFILE_DIR/$1 ~/$1"
  ln -sf $DOTFILE_DIR/$1 ~/$1
}


function main() {
  install-git
  configure-git

  git clone https://github.com/$GITHUB_USER/dotfiles.git ~/dotfiles

  # create backup dir
  echo "Creating $DOTFILE_BACKUP_DIR for backup of any existing dotfiles in ~"
  mkdir -p $DOTFILE_BACKUP_DIR

  # Ubuntu
  files=".profile .bashrc .bash_prompt .bash_aliases .functions .env .curlrc .vimrc .tmux.conf"
  
  for file in $files; do
    create-symlink $file
  done

}

main $*

exit 0
