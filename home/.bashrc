#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="$HOME/.bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='modern-r'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source $BASH_IT/bash_it.sh

# Load common variables
if [ -e "${HOME}/.env" ]
then
  source "${HOME}/.env"
fi
# This is bashrc, so set the SHELL to bash
export SHELL="bash"

# And reload the alias_completions to get alias subcommands working
if [ -e "${BASH_IT}/plugins/enabled/alias-completion.plugin.bash" ]
then
  source "${BASH_IT}/plugins/enabled/alias-completion.plugin.bash"
fi

export NVM_DIR="$HOME/.nvm"
export NVM_DEFAULT="v7.7.4"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

if [[ $(uname) == "Darwin" ]]; then
  PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi
