SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_green}${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

case $TERM in
	xterm*)
	TITLEBAR="\[\033]0;\w\007\]"
	;;
	*)
	TITLEBAR=""
	;;
esac

PS3=">> "

is_vim_shell() {
	if [ ! -z "$VIMRUNTIME" ]
	then
		echo "[${cyan}vim shell${normal}]"
	fi
}

modern_scm_prompt() {
	CHAR=$(scm_char)
	if [ $CHAR = $SCM_NONE_CHAR ]
	then
		return
	else
		echo "[$(scm_char)][$(scm_prompt_info)]"
	fi
}

modern_rvm_prompt() {
	local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
	local full="$version"
	[ "$full" != "" ] && echo "ruby-$full"
}

modern_nvm_prompt() {
	if hash node 2>/dev/null; then
		local current=$(nvm current)
		# local default=$(nvm alias --no-colors default | rev | cut -d' ' -f2 | rev)
		local default=$NVM_DEFAULT
	fi
	if [ $(nvm current) = "system" ]; then
		echo ""
	else	
		[ "$current" != "$default" ] && echo "node-$current"
	fi
}

modern_version_managers_prompts() {
	local vms=""
	if [ "$(modern_rvm_prompt)" !=  "" ] && [ "$(modern_nvm_prompt)" != "" ]
	then
		vms="${red}$(modern_rvm_prompt) ${yellow}$(modern_nvm_prompt)"
	elif [ "$(modern_rvm_prompt)" != "" ] && [ "$(modern_nvm_prompt)" = "" ]
	then
		vms="${red}$(modern_rvm_prompt)"
	elif [ "$(modern_nvm_prompt)" != "" ] && [ "$(modern_rvm_prompt)" = "" ]
	then
		vms="${yellow}$(modern_nvm_prompt)"
	fi
	echo "$vms${normal}"
}

prompt() {
	if [ $? -ne 0 ]
	then
		# Yes, the indenting on these is weird, but it has to be like
		# this otherwise it won't display properly.

    PS1="${TITLEBAR}${bold_red}┌─${reset_color}$(modern_scm_prompt)[${bold_blue}\w${normal}][$(modern_version_managers_prompts)]$(is_vim_shell)
${bold_red}└─▪${normal} "
	else
		PS1="${TITLEBAR}┌─$(modern_scm_prompt)[${bold_blue}\w${normal}][$(modern_version_managers_prompts)]$(is_vim_shell)
└─▪ "
	fi
}

PS2="└─▪ "



safe_append_prompt_command prompt
