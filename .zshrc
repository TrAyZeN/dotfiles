# History configuration
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_find_no_dups

unsetopt beep

# Git
source ~/gitstatus/gitstatus.plugin.zsh

# Prompt
function set_prompt() {
    STATUS=''

    if gitstatus_query prompt && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        STATUS=[${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%} # escape %
        (( VCS_STATUS_NUM_STAGED    )) && STATUS+=" +${VCS_STATUS_NUM_STAGED}"
        (( VCS_STATUS_NUM_UNSTAGED  )) && STATUS+=" !${VCS_STATUS_NUM_UNSTAGED}"
        (( VCS_STATUS_NUM_UNTRACKED )) && STATUS+=" ?${VCS_STATUS_NUM_UNTRACKED}";
        STATUS+="] "
    fi

    # Only working with 256 colors
    PROMPT="%F{45}%n%f:%F{184}%d%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "
    RPROMPT=""

    setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'prompt' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'prompt'
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

export LS_COLORS='ow=01;36;40'

# Enable vim bindings
# bindkey -v

# Completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/trayzen/.zshrc'
compinit

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
