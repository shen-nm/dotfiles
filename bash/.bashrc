# --- PATHS ---
export EDITOR=nvim
export PATH="$PATH:/usr/lib/ccache/bin/:$HOME/.cargo/bin/:$HOME/.local/bin/"
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1
export NVD_BACKEND=direct
export SCREENSHARE_RESTORE_TOKEN=1
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_SIZE=10000000000 # This is 10GB
export ELECTRON_OZONE_PLATFORM_HINT=auto
export QT_QPA_PLATFORMTHEME=qt6ct
export BROWSER="vivaldi-stable"

if [ "$XDG_CURRENT_DESKTOP" != "KDE" ] && [ "$XDG_CURRENT_DESKTOP" != "plasma" ]; then
    export XDG_CURRENT_DESKTOP=niri
    export XDG_SESSION_DESKTOP=niri
fi
 
# --- SYSTEM ALIASES ---
alias c='clear'
alias nf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias v='$EDITOR'
alias vim='$EDITOR'
alias wifi='nmtui'
alias shutdown='systemctl poweroff'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias sysupdate='sudo pacman -Syu'
alias install='sudo pacman -S'

# --- GIT ALIASES ---
alias gi="git init"
alias gb="git branch -M main"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"

# --- CUSTOM ALIASES ---
alias vsc='vscodium'
alias dc='docker'
alias storage='ncdu'
alias vpn='protonvpn'
alias jarvis="~/.local/bin/odysseus-runner.sh"
alias upload-music="mv ~/Music/Temp-sync/* ~/Music/Library/ && flac2mp3.sh && sync-music.sh"
alias cdniri="cd ~/.config/niri/"
alias lg="lazygit"

# --- TERMINAL TEXT ---
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.toml)"

# --- MUSIC ---
alias get-music='~/.local/bin/get-music.sh'

# --- CUSTOM COMMANDS ---
mkcd() {
	mkdir -p "$1"
	cd "$1"
}

# FuzzyFinder
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Source the Arch Linux native fzf key-bindings
if [ -n "$BASH_VERSION" ]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
elif [ -n "$ZSH_VERSION" ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# --- AUTOSTART ---
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
fi


