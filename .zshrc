# History configuration
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_find_no_dups

unsetopt beep

# Word delimiters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

PLUGIN_DIR="/usr/share/zsh/plugins"

# Git
source "$PLUGIN_DIR/gitstatus/gitstatus.plugin.zsh"

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
    #PROMPT="%F{45}%n%f:%F{184}%d%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "

    SPLIT_PWD=($(echo $PWD | tr "/" "\n"))
    SHORT_PWD="/"
    for part in "${SPLIT_PWD[@]:0:${#SPLIT_PWD[@]}-1}"; do
        SHORT_PWD+="${part:0:1}/"
    done
    SHORT_PWD+=${SPLIT_PWD[-1]}

    # Shorten prompt
    PROMPT="%F{184}${SHORT_PWD}%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "
    RPROMPT=""

    setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'prompt' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'prompt'
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

export LS_COLORS='ow=01;36;40'

# Enable vim bindings
# bindkey -v

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

# Bind ctrl+arrow to move by word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Bind ctrl+backspace to delete word
bindkey "^H" backward-kill-word

# Rebind alt+backspace to delete single char
bindkey "^[^?" backward-delete-char

# Convenient fg
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

# mkdir and then cd
mkcd() {
    mkdir -p $1 && cd $1
}

# mktemp and then cd
mkcdtemp() {
    cd $(mktemp -d)
}

# Load aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# Completion
autoload -Uz compinit
fpath=($PLUGIN_DIR/zsh-completions/src $fpath)
zstyle ':completion:*' menu select
zstyle :compinstall filename "$HOME/.zshrc"

# fzf-tab needs to loaded after compinit, but before plugins which will wrap
# widgets, such as zsh-autosuggestions or fast-syntax-highlighting
# source "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

compinit

path+=("$HOME/.local/bin")
export PATH
