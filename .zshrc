########################################
# PROMPT INSTANT LOAD
########################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# CORE FEATURES
########################################
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY
HIST_STAMPS="dd/mm/yyyy"
export DIRSTACKSIZE=20

########################################
# ZINIT BOOTSTRAP
########################################
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

########################################
# ZINIT ANNEXES & PLUGINS
########################################
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
zinit ice depth"1" 
zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab 
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# COMPLETION SYSTEM INIT
########################################
[ -d "$HOME/.cache/zsh" ] || mkdir -p "$HOME/.cache/zsh"
autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"
source <(fzf --zsh)

########################################
# KEYBINDINGS
########################################
bindkey -v
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

########################################
# SHELL OPTIONS
########################################
setopt autocd correct interactivecomments magicequalsubst nonomatch notify numericglobsort promptsubst

########################################
# ENVIRONMENT
########################################
export KITTY_CONFIG_FILE="$HOME/.config/kitty/kitty.conf"
export EDITOR=nvim visudo
export VISUAL=nvim visudo
export SUDO_EDITOR=nvim
export FCEDIT=nvim
export TERMINAL=alacritty
export BROWSER=brave-browser

########################################
# HISTORY
########################################
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

########################################
# COMPLETION & FZF-TAB
########################################
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

########################################
# ALIASES & PATHS
########################################
alias ai="gh copilot explain"
alias explain="gh copilot explain"
alias google="googler"
alias brave='brave-browser'
alias files='nautilus ./ &'
export PATH="$HOME/go/bin:$HOME/.cargo/bin:$PATH"