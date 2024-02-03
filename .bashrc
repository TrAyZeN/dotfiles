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

# mkdir and then cd
mkcd() {
    mkdir -p $1 && cd $1
}

# mktemp and then cd
mkcdtemp() {
    cd $(mktemp -d)
}

# Extract archive of various types
ex () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


# new alert text
ALERT=${BWhite}${BGRed} # Bold White on red background

[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PS1="\[\033[38;5;43m\]\w\[\033[38;5;7m\] \[\033[38;5;82m\]~>\[\e[m\] "

[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b $DIR_COLORS`"

export LS_COLORS='ow=01;36;40'

