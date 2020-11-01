#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Make colorcoding available for everyone

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
BGBlack='\e[40m'       # Black
BGRed='\e[41m'         # Red
BGGreen='\e[42m'       # Green
BGYellow='\e[43m'      # Yellow
BGBlue='\e[44m'        # Blue
BGPurple='\e[45m'      # Purple
BGCyan='\e[46m'        # Cyan
BGWhite='\e[47m'       # White

NC="\e[m"               # Color Reset


# new alert text
ALERT=${BWhite}${BGRed} # Bold White on red background

[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Prompt
export PS1="\[\033[38;5;43m\]\u\[\033[38;5;7m\]@\[\033[38;5;69m\]\h\
\[\033[38;5;7m\] \w \[\033[38;5;82m\]~>\[\e[m\] "

[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b $DIR_COLORS`"

export LS_COLORS='ow=01;36;40'

