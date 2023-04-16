if status is-interactive
 fish_add_path /opt/homebrew/bin
 fish_vi_key_bindings

# ----------------------------- GREETINGS ------------------------------
        function fish_greeting

        set_color green 
         echo  "

                    █░█ █▀▀   █░█ █▀▄ ▄▀█ █▀█ ▄▀█ █▄░█ ░░█ █▀▀
                    █▀█ █▄▄   █▄█ █▄▀ █▀█ █▀▄ █▀█ █░▀█ █▄█ ██▄    ¯\_( ͠° . ͡°)_/¯
              
         "

        end
# ----------------------------- GREETINGS ------------------------------

 bind -M insert -m default jj 'commandline -f repaint'

  function fish_user_key_bindings
      for mode in insert default visual
          bind -M $mode \cf forward-char
      end
  end



# ----------------------------- ALIAS ------------------------------
#
# kekomi
alias kekomi="cd ~/kodius/kekomi/next"
#
# kodiui
alias kodiui="cd ~/kodius/kodiui-core/packages/ui"
alias kodiplay="cd ~/kodius/kodiui-core/apps/playground"
alias kodidocs="cd ~/kodius/kodiui-core/apps/docs"
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
alias emacs="~/.config/emacs/bin"
alias lc="lvim ~/"
#
# neovim
alias conf="nvim ~/.config/nvim"
#
# dis
alias dis="cd ~/kodius/discovery/healthOrganizationFrontendUsersV2"
alias disa="cd ~/kodius/discovery/discovery-fe-admin"
#
# alacritty config
alias ac="nvim ~/.config/alacritty/alacritty.yml"
#
# kitty config
alias kc="nvim ~/.config/kitty/kitty.conf"
# fish config
alias fc="nvim ~/.config/fish/config.fish"
#
# ranger
alias ra="ranger"
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
# ----------------------------- ALIAS ------------------------------

end


# Setting PATH for Python 3.11
# The original version is saved in /Users/dino/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
