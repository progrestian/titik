# EXPORTS

export EDITOR=nvim
export GPG_TTY=$(tty)
export LESS='-r'
export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
export TERM=xterm
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json
export _JAVA_AWT_WM_NONREPARENTING=1

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export ADB_VENDOR_KEY="$XDG_CONFIG_HOME"/android
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export JAVA_HOME="$XDG_DATA_HOME/jdks/adopt-openjdk-15.0.1"
export LEIN_HOME="$XDG_DATA_HOME"/lein
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$XDG_DATA_HOME/cargo/bin"

# ALIASES

alias bw="$XDG_DATA_HOME/npm/bin/bw"
alias exh="exa -a"
alias exl="exa -al"
alias exr="exa -R -L "
alias ext="exa -T -L "
alias ls="exa"
alias rrm="/bin/rm"
alias tmtbl="libreoffice --view ~/cloud/inf/timetable.ods &! exit"
alias du="sudo dnf update-y; flatpak update -y"
alias di="sudo dnf install -y "
alias ds="sudo dnf search "

alias ga="git add"
alias gaa="git add ."
alias gb="git branch"
alias gbc="git branch --merged | grep -v '\*\|master\|develop' | xargs -n 1 git branch -d"
alias gc="git commit"
alias gco="git checkout"
alias gf="git fetch"
alias gl="git log"
alias gln="git log --no-merges"
alias glg="git log --graph --oneline --all"
alias glgn="git log --graph --oneline --all --no-merges"
alias gm="git merge --no-ff"
alias gp="git push"
alias gpl="git pull"
alias gr="git rebase"
alias grm="git rebase main"
alias gs="git status -sb"

# FUNCTIONS

function bd() {
  local level=$1
  if [ -n "$1" ]; then level=1; fi
  for i in {1..$1}; do
    if [ "$PWD" != "$HOME" ]; then cd ..; fi
  done
}

function bwp() {
  if [ -z $1 ]; then return; fi
  if [ -z $BW_SESSION ]; then export BW_SESSION=$(bw --raw unlock); fi
  wl-copy $(bw get password "$1")
}

function bwu() {
  if [ -z $1 ]; then return; fi
  if [ -z $BW_SESSION ]; then export BW_SESSION=$(bw --raw unlock); fi
  wl-copy $(bw get username "$1")
}

function cdv() {
  curl -o /dev/null -s -w %{json} $1 | jq
}

function clr() {
  clear
  if [ "$PRECMD_FIRST_PROMPT" = false ]; then PRECMD_FIRST_PROMPT=true; fi
}

function fzi() {
  local file=$(find ~/cloud/img -type f | fzf)
  if [ ! -z "$file" -a "$file" != " " ]; then imv -r $file; fi
}

function fzk() {
  kill -9 $(ps -eo pid,cmd | fzf | awk "{print \$1}")
}

function fzo() {
  cd $(find . -type d | fzf)
}

function fzr() {
  flatpak run $(flatpak list --columns=application | fzf) &! exit
}

function fzv() {
  local file=$(find ~/.config \
    -name .netrwhist.conf -prune -o \
    -name Trolltech.conf -prune -o \
    -name VSCodium -prune -o \
    -name build -prune -o \
    -name chromium -prune -o \
    -name dconf -prune -o \
    -name libreoffice -prune -o \
    -name pipewire -prune -o \
    -name pulse -prune -o \
    -name tool-options -prune -o \
    -type f -print | fzf --preview='head -$LINES {}')

  if [ ! -z "$file" -a "$file" != " " ]; then nvim $file; fi
}

function fzw() {
  local ssid=$(nmcli -e yes -f "ssid,rate,signal,security" d wifi list | fzf --header-lines=1 --reverse --delimiter="," | awk 'BEGIN {FS="   *"}; {print $1}')
  if [ ! -z "$ssid" -a "$ssid" != " " ]; then nmcli --ask d wifi connect "$ssid"; fi
}

function gd() {
  local file=$(git ls-files -m | grep -v 'LICENSE\|README.md' | fzf)
  if [ ! -z "$file" -a "$file" != " " ]; then git diff $file; fi
}

function gpu() {
  git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

function rm() {
  if [ ! -d "$HOME/.local/share/Trash/files" ]; then mkdir -p "$HOME/.local/share/Trash/files"; fi
  mv $1 "$HOME/.local/share/Trash/files"
}

# ZSH

bindkey "^[[3~" delete-char
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[f"   forward-word
bindkey "^[b"   backward-word

autoload -Uz compinit
compinit

PROMPT="%F{yellow}%~%F{white}"$'\n'"%# "
PRECMD_FIRST_PROMPT=true

function precmd() {
  if [ "$PRECMD_FIRST_PROMPT" = true ]; then
    PRECMD_FIRST_PROMPT=false
  else
    print ""
  fi
}

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling: %p%s
zstyle :compinstall filename '/home/progrestian/.zshrc'

# AUTOSTART

if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then exec sway; fi
