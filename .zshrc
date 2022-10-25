export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cloud"

plugins=(git)

source $ZSH/oh-my-zsh.sh


set -o vi



# ----------------------------- ALIAS ------------------------------
#
#
#
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
# git
alias ga.="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias grs="git reset --soft HEAD~1"
alias gs="git status"
# 
# 
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

eval "$(pyenv init --path)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#
#
#
#
# ----------------------------- ALIAS ------------------------------

