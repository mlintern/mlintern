#color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

PROMPT="
${fg_pink}%n${fg_blue}@${fg_red}${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white}]
[${fg_green}%*${fg_white}]${fg_purple}:-> ${at_normal}"

#${fg_pink}%n${fg_blue}@${fg_red}${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white}]
#[${fg_green}%T${fg_white}]${fg_purple}:-> ${at_normal}"

HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000

#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls -G' #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable

##Set environment for creating Amazon Instanced in Production or Test ENV
alias set-prod='. ~/.ec2/set-prod-env' 
alias set-test='. ~/.ec2/set-test-env' 

##Set Screen Shortcuts
alias screen-test='screen -c .screenrc-test'
alias screen-blog='screen -c .screenrc-blog'
alias screen-pres-cb='screen -c .screenrc-pres-cb'

##cd, because typing the backslash is ALOT of work!!
#alias .='cd ../'
#alias ..='cd ../../'
#alias ...='cd ../../../'
#alias ....='cd ../../../../'

#Setting Amazon EC2 Tools location Production
set-prod

#Functions

# Only works with ZSH, uses zmodload zsh/regex module
servs() { grep "$*" ~/Documents/servers.csv }
servhostname() { grep "$*" ~/Documents/servers.csv | tail -1 | awk -F, '{print $1}' }
servconnect() {
	zmodload zsh/regex
	server=`servs $* | tail -1 | awk -F, '{print $2}'| sed 's/ //'`
	hostname=`servhostname ${server}`
	if [[ "${hostname}" -regex-match ^(prod|test).*$ ]]; then
		ssh_user=ec2-user
	else
		ssh_user=root
	fi
	echo "Connecting to ${ssh_user}@$server"
	ssh -i ~/.ssh/rightscale_key -l $ssh_user $server
}

