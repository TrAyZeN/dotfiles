# History configuration
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_find_no_dups

# Only working with 256 colors
PROMPT="%F{45}%n%f %F{yellow}%d%f %(?.%F{46}~>%f.%F{197}~>%f) "

# Aliases
alias ls="ls -CF --color=auto"
alias grep="grep --color=auto"

export LS_COLORS='ow=01;36;40'

unsetopt beep

# Git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Enable vim bindings
# bindkey -v

# Default settings i had

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/leo/.zshrc'

# Completion
autoload -Uz compinit && compinit

