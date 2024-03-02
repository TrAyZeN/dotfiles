# History configuration
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_find_no_dups

export XDG_CONFIG_HOME="$HOME/.config"

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

    SHORT_PWD=$(echo "$PWD" | sed -E 's/([^/])[^/]*\//\1\//g')

    # Shorten prompt
    #PROMPT="%F{184}${SHORT_PWD}%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "
    PROMPT="%F{184}${SHORT_PWD}%f %F{208}${STATUS}%f%(?.%F{46}ᛋ%f.%F{197}ᛋ%f) "
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
    if [ "$#" -lt 1 ]; then
        echo "mkcd: missing directory path" 1>&2
        false
    else
        mkdir -p -- "$1" && cd -- "$1"
    fi
}

# mktemp and then cd
mkcdtemp() {
    cd -- "$(mktemp -d)"
}

# Extract archive of various types
ex() {
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
             *.7z)        7z x $1        ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file" 1>&2
         false
     fi
}

# Return latest file in the given dir
get_latest() {
    local latest=""

    for file in "$1"/*; do
        if [ -z "$latest" ] || [ "$file" -nt "$latest" ]; then
            latest="$file"
        fi
    done

    echo "$latest"
}

# Move latest downloaded file into temp dir
dlexp() {
    local download_dir=~/Downloads
    # TODO: Check if dir exists

    local latest="$(get_latest "$download_dir")"
    local tmp_dir="$(mktemp -d)"
    mv "$latest" "$tmp_dir"

    cd "$tmp_dir"

    # If it is an archive extract it
    ex "$(basename $latest)" > /dev/null
}

# Move latest dowloaded file in the given dir
mvl() {
    local download_dir=~/Downloads
    mv "$(get_latest "$download_dir")" "$1"
}

# Append given path to the PATH
path_append() {
    export OLDPATH=$PATH
    export PATH=$PATH:$1
}

bindkey -s '^j' 'fg^M'

# Load aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/

export EDITOR="nvim"

# For some reason when setting EDITOR environment variables disables Emacs style
# bindings
bindkey -e

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
source "$PLUGIN_DIR/zsh-bd/bd.plugin.zsh"

compinit

# Help
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -Uz run-help-btrfs run-help-docker run-help-git run-help-ip \
    run-help-openssl run-help-p4 run-help-perf run-help-podman run-help-ssh \
    run-help-sudo run-help-svn run-help-svnadmin

path+=("$HOME/.local/bin")
export PATH

export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export GTK_THEME="Qogir:dark"

# eval "$(direnv hook zsh)"
