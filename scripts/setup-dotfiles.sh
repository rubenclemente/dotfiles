#!/usr/bin/env bash


DOTFILE_DIR=~/dotfiles
DOTFILE_BACKUP_DIR=~/dotfiles-backup

function install-git() {
  if ! [ -x "$(command -v git)" ]; then
    if [ -x "$(command -v apt-get)" ]; then
      apt-get update
      apt-get install git -y
    fi
    if ! [ -x "$(command -v git)" ]; then
      printf "\nThis script requires git!\n"
      exit 1
    fi
  fi
}

function create_symlink() {
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

  git clone https://github.com/rubenclemente/dotfiles.git ~/dotfiles

  # create backup dir
  echo "Creating $DOTFILE_BACKUP_DIR for backup of any existing dotfiles in ~"
  mkdir -p $DOTFILE_BACKUP_DIR

  #files=".bash_profile .profile .bashrc .bash_aliases .bash_prompt .functions .env .gitignore .curlrc"
  # Ubuntu
  files=".profile .bashrc .bash_prompt .bash_aliases .functions .env .curlrc"
  
  for file in $files; do
    create_symlink $file
  done


  git config --list

  #echo "Enter Git fullname:"
  #read GIT_FULLNAME
  #echo "Requesting root permissions to set git config at system level..."
  #sudo git config --system user.name $FULLNAME
  #echo "Success."

  #echo "Enter Git email address:"
  #read GIT_EMAIL
  #echo "Requesting root permissions to set git config at system level..."
  #sudo git config --system user.email $GIT_EMAIL
  #echo "Success."
}

main $*

exit 0
