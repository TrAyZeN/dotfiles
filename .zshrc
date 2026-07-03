typeset -U path PATH
# Load env vars
[ -f "$HOME/.profile" ] && emulate sh -c 'source "$HOME/.profile"'

# History configuration
HISTFILE="$HOME/.histfile"
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt share_history          # sync history across concurrent sessions
setopt extended_history       # record timestamps
setopt hist_reduce_blanks
setopt hist_ignore_space      # commands starting with a space aren't recorded

unsetopt beep

# Word delimiters
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Completion
# autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle :compinstall filename "$HOME/.zshrc"

# Rebuild completion cache only once a day
# See: https://gist.github.com/ctechols/ca1035271ad134841284?permalink_comment_id=3994613#gistcomment-3994613
# if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  # compinit
# else
  # compinit -C
# fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Plugins
zinit ice wait lucid \
    atload'gitstatus_stop prompt; gitstatus_start -s -1 -u -1 -c -1 -d -1 prompt'
zinit light romkatv/gitstatus

# fzf-tab needs to loaded after compinit, but before plugins which will wrap
# widgets, such as zsh-autosuggestions or fast-syntax-highlighting
# source "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"

zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf \
        zsh-users/zsh-completions

# Prompt
function set_prompt() {
    STATUS=''

    if (( $+functions[gitstatus_query] )) && gitstatus_query prompt && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        STATUS=[${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%} # escape %
        (( VCS_STATUS_NUM_STAGED    )) && STATUS+=" +${VCS_STATUS_NUM_STAGED}"
        (( VCS_STATUS_NUM_UNSTAGED  )) && STATUS+=" !${VCS_STATUS_NUM_UNSTAGED}"
        (( VCS_STATUS_NUM_UNTRACKED )) && STATUS+=" ?${VCS_STATUS_NUM_UNTRACKED}";
        STATUS+="] "
    fi

    # Only working with 256 colors
    #PROMPT="%F{45}%n%f:%F{184}%d%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "

    # SHORT_PWD=$(echo "$PWD" | sed -E 's/([^/])[^/]*\//\1\//g')
    # This is supposed to be the same short-prompt as with sed
    setopt local_options extended_glob
    SHORT_PWD=${${PWD/#$HOME/~}//(#b)([^\/])[^\/]#\//$match[1]/}

    # Shorten prompt
    #PROMPT="%F{184}${SHORT_PWD}%f %F{208}${STATUS}%f%(?.%F{46}~>%f.%F{197}~>%f) "
    PROMPT="%F{184}${SHORT_PWD}%f %F{208}${STATUS}%f%(?.%F{46}>%f.%F{197}ᛋ%f) "
    RPROMPT=""
}

setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt

export LS_COLORS='ow=01;36;40'

# Set keymap
# NOTE: For some reason setting EDITOR environment variables to nvim disables
# Emacs style bindings. So make sure this is called after setting EDITOR.
bindkey -e

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

# Less previous command
lessp() {
    fc -s | less
}

# Append given path to the PATH
path_append() {
    export OLDPATH=$PATH
    export PATH=$PATH:$1
}

bindkey -s '^j' 'fg^M'

# Load aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# Help
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -Uz run-help-btrfs run-help-docker run-help-git run-help-ip \
    run-help-openssl run-help-p4 run-help-perf run-help-podman run-help-ssh \
    run-help-sudo run-help-svn run-help-svnadmin

# direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# Fix proxy error when cursor uses cargo
# https://github.com/cursor/cursor/issues/549
if [[ "$TERM_PROGRAM" == "vscode" || -n "$CURSOR_TRACE_ID" || -n "$CURSOR_AGENT" ]]; then
    unset ARGV0
fi
