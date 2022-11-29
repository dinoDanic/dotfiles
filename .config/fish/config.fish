if status is-interactive
    # Commands to run in interactive sessions can go here

 fish_vi_key_bindings

# ----------------------------- GREETINGS ------------------------------
        function fish_greeting
         echo "

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
alias conf="nvim ~/.config/nvim"
#
# dis
alias dis="cd ~/kodius/discovery/healthOrganizationFrontendUsersV2"
#
# alacritty config
alias ac="nvim ~/.config/alacritty/alacritty.yml"
#
# kitty config
alias kc="nvim ~/.config/kitty/kitty.conf"
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
# ----------------------------- ALIAS ------------------------------

end

