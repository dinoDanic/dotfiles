if status is-interactive
 fish_add_path /opt/homebrew/bin
 fish_vi_key_bindings
 zoxide init fish | source 

# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'


# ----------------------------- GREETINGS ------------------------------
        function fish_greeting

        set_color blue 
         echo  "

           █░█ █▀▀   █░█ █▀▄ ▄▀█ █▀█ ▄▀█ █▄░█ ░░█ █▀▀         
           █▀█ █▄▄   █▄█ █▄▀ █▀█ █▀▄ █▀█ █░▀█ █▄█ ██▄  

                   (づ｡◕‿‿◕｡)づ  ναzιη     ٩(˘◡˘)۶
    "
    echo "
    "

        end
# ----------------------------- GREETINGS ------------------------------

 bind -M insert -m default jj 'commandline -f repaint'

  function fish_user_key_bindings
      for mode in insert default visual
          bind -M $mode \cf forward-char
      end
  end



# ----------------------------- TMUX -------------------------------
function develop
    tmux -neww session_name: -n window_name -d
end

# ----------------------------- PATHS ------------------------------
# KOIDUI
set -x KODIUI_PATH ~/kodius
set -x KODIUI_MY_PROJECT_PATH ~/projects/bmb-elixir/bmb-fe

# ----------------------------- ALIAS ------------------------------

# react native

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/platform-tools

#flutter


# set PATH /development/flutter/bin $PATH
set -gx PATH Users/dino/development/flutter/bin $PATH

function flutter
    fvm flutter $argv
end

# function air
#     $GOPATH/bin/air $argv
# end

set -gx GOPATH "/Users/dino/go"

# swag
alias swag=$GOPATH/bin/swag

# air
alias air=$GOPATH/bin/air 

# templ
alias templ=$GOPATH/bin/templ 

# kitty
alias s="kitty +kitten ssh"
#
# milivoja kitty
# alias milivoje="kitty +kitten ssh root@192.168.20.25"
alias dinosur="kitty +kitten ssh root@dinosur.app"
# alias milivoje_vani="kitty +kitten ssh root@185.155.224.196 -p 21222"
alias serverina_vani="kitty +kitten ssh kodius@185.98.12.29 -p 22001"

alias milivoje="ssh root@192.168.20.25"
alias milivoje_vani="ssh root@185.155.224.196 -p 21222"
alias serverina="ssh kodius@192.168.10.68"

# problem with this aliases the docker must run..

# alias swarm.restart='systemctl restart docker'
# alias swarm.down='docker stack rm'
# alias swarm.up='docker stack deploy -c stack.yml'
# alias swarm.ram="docker stats  --no-stream --format '{{.MemPerc}}\t{{.MemUsage}}\t{{.Name}}' $(docker ps -q -f name=CONTAINER_NAME) | sed -u 's/\x1b\[[0-9;]*[a-zA-Z]//g' | sort -k 2 -h | tee stats"

# xchange
alias xchange="cd ~/kodius/xchange-fe"
# kekomi
alias kekomi="cd ~/kodius/kekomi/next"
#
# kodiui
alias kodiui="cd ~/kodius/kodiui-core/packages/ui"
alias kodiplay="cd ~/kodius/kodiui-core/apps/playground"
alias kodidocs="cd ~/kodius/kodiui-core/apps/kodidocs"
alias kodicli="cd ~/kodius/kodiui-core/packages/cli"
alias kodicore="cd ~/kodius/kodiui-core"
#
# opti
alias opti="cd ~/kodius/cosmicfrog-model-editor-service"
# we-get-music-core
alias wgm="cd ~/kodius/wegetmusic/wegetmusic-fe-core"
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

#
# neovim
alias nc="cd ~/.config/nvim && nvim"
alias n="nvim"
#
alias tnf="cd ~/kodius/tnf/tnf-frontend"
#
# history
alias h="history"
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
alias rc="nvim ~/.config/ranger/rc.conf"
#
# tmux
alias tc="nvim ~/.tmux.conf"
alias t="tmux"
alias tn="tmux new -s"
#
# git
alias ga.="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias grs="git reset --soft HEAD~1"
alias gs="git status"
# 
# comands
# alias ll="ll -a"

# ----------------------------- ALIAS ------------------------------

end


# Setting PATH for Python 3.11
# The original version is saved in /Users/dino/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

# pnpm
set -gx PNPM_HOME "/Users/dino/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# bun
