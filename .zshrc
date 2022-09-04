export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

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
# opti
alias opti="cd ~/kodius/cosmicfrog-model-editor-service"
#
# bmb
alias bmb="cd ~/projects/bmb"
#
# Sunny side
alias sunny="cd ~/kodius/sunnyside/sunnyside-frontend"
alias sunnystart="cd ~/kodius/sunnyside/sunnyside-frontend; code .; open -a 'Google Chrome' http://localhost:3000/; yarn dev" 
#
# lunarvim 
alias lvim="/Users/dino/.local/bin/lvim"
#
# neovim
alias conf="cd ~/.dotfiles/.config/nvim; nvim ."
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
