## My Bash dotfiles

---

I have taken [Bran van der Meer](https://github.com/branneman/dotfiles) dotfiles repository as a starting point.

Interesting information here: https://dotfiles.github.io/tutorials/

## Installation

- Without git installed:
```bash
curl https://raw.githubusercontent.com/rubenclemente/dotfiles/scripts/setup-dotfiles.sh | sh -s
```

- With git installed:
```bash
git clone git@github.com:rubenclemente/dotfiles.git ~/dotfiles
cd ~/dotfiles/scripts
source setup-dotfiles.sh
```

## Shells

- Interactive, login shell: when we log in to a system using ssh (the first found will be executed):

	> [/etc/profile] >> bash_profile >> .bash_login >> .profile

	In Ubuntu we have [.profile] which calls [.bashrc]

- Interactive, non-login shell: when we invoke a new shell on an already logged-in shell.

	> [.bashrc]

- Non-interactive shell: when a shell doesn’t need human intervention to execute commands (when a script forks a child shell).

	> no startup file > It inherits environment variables from the shell that created it.


## Bash Startup Files

- .bash_profile

To set environment variables.
Since the interactive login shell is the first shell, all the default settings required for the environment setup are put in .bash_profile. Consequently, they are set only once but inherited in all child shells.


- .bashrc

Normally is the best place to add aliases and Bash related functions.


- .profile

Can hold the same configurations as .bash_profile or .bash_login.
It controls prompt appearance, keyboard sound, shells to open, and individual profile settings that override the variables set in the /etc/profile file.


To avoid login and non-login interactive shell setup difference, .bash_profile calls .bashrc.


## Adding a new configuration file

- Create the file inside 'dotfiles' folder

$ touch ~/dotfiles/.vimrc

- Create a symlink from '/home/user/.vimrc' to '/home/user/dotfiles/.vimrc'

$ ln -sf ~/dotfiles/.vimrc ~/.vimrc

- Push the new file to the repo


## Other configuration files

- .vimrc
- .tmux.conf


## Journal

- sudo apt install tree
- 
