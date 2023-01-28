# ------------------------------- ZSH -------------------------------
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="cloud"
# Plugins
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting )



# source $ZSH/oh-my-zsh.sh

# ------------------------------- ZSH -------------------------------
#



set -o vi

# ----------------------------- Keybinds ------------------------------
#
bindkey '^ ' autosuggest-accept
#
# ----------------------------- ALIAS ------------------------------
#
# kekomi
alias kekomi="cd ~/kodius/kekomi/next"
#
# kodiui
alias kodiui="cd ~/kodius/kodiui"
alias kodi="cd ~/kodius/kodiui"
#
# opti
alias opti="cd ~/kodius/cosmicfrog-model-editor-service"
#
# bmb
alias bmb="cd ~/projects/bmb"
#
# forfend-web
alias ffweb="cd ~/kodius/forfend/forfend-web"
#
# Sunny side
alias sunny="cd ~/kodius/sunnyside/sunnyside-frontend"
alias sunnystart="cd ~/kodius/sunnyside/sunnyside-frontend; code .; open -a 'Google Chrome' http://localhost:3000/; yarn dev" 
#
# lunarvim 
alias lvim="/Users/dino/.local/bin/lvim"
alias lc="lvim ~/"
#
# neovim
alias conf="cd ~/.dotfiles/.config/nvim; nvim ."
#
# dis
alias dis="cd ~/kodius/discovery/health-organization-frontend-users-v2"
#
# alacritty config
alias ac="lvim ~/.config/alacritty/alacritty.yml"
#
# kitty config
alias kc="lvim ~/.config/kitty/kitty.conf"
#
# ranger
alias ra="ranger"
#
# nezalijevam
alias nez="cd ~/projects/nezalijvam"
alias nezbe="cd ~/projects/nezalijevambe"
#
# tmux
alias tmuxa0="tmux attach-session -t 0"
alias tmuxa1="tmux attach-session -t 1"
alias tmuxa2="tmux attach-session -t 2"
alias tmuxk0="tmux kill-session -t 0"
alias tmuxk1="tmux kill-session -t 1"
alias tmuxk2="tmux kill-session -t 2"
alias tmuxka="tmux kill-server"
#
# git
alias ga.="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias grs="git reset --soft HEAD~1"
alias gs="git status"
# 
# 

#
#
#
#
# ----------------------------- ALIAS ------------------------------
