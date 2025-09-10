if status is-interactive
    fish_add_path /opt/homebrew/bin
    fish_vi_key_bindings
    zoxide init fish | source

    # ----------------------------- GREETINGS ------------------------------
    function fish_greeting

        set_color blue
        echo "

           █░█ █▀▀   █░█ █▀▄ ▄▀█ █▀█ ▄▀█ █▄░█ ░░█ █▀▀         
           █▀█ █▄▄   █▄█ █▄▀ █▀█ █▀▄ █▀█ █░▀█ █▄█ ██▄  

                   (づ｡◕‿‿◕｡)づ  ναzιη     ٩(˘◡˘)۶
    "
        echo "
    "

    end
    # ----------------------------- KEYBINDS ------------------------------

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

    # -------------------------- AEROSPACE -----------------------------

    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end

    # ----------------------------- PATHS ------------------------------

    # react native
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    set -gx PATH $PATH $ANDROID_HOME/emulator
    set -gx PATH $PATH $ANDROID_HOME/platform-tools

    # flutter
    set -gx PATH Users/dino/development/flutter/bin $PATH

    function flutter
        fvm flutter $argv
    end

    set -gx GOPATH /Users/dino/go

    # ----------------------------- AEROSPACE ------------------------------
    function sf
        aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
    end

    # ----------------------------- ALIAS ------------------------------

    # swag
    alias swag=$GOPATH/bin/swag

    # air
    alias air=$GOPATH/bin/air

    # templ
    alias templ=$GOPATH/bin/templ

    # lunarvim 
    alias lvim="/Users/dino/.local/bin/lvim"

    # neovim
    alias nc="cd ~/.config/nvim && nvim"
    alias n="nvim"

    # globals
    alias h="history"

    # alacritty 
    alias ac="nvim ~/.config/alacritty/alacritty.toml"

    # kitty 
    alias kc="nvim ~/.config/kitty/kitty.conf"

    # fish 
    alias fc="nvim ~/.config/fish/config.fish"

    # tmux
    alias tc="nvim ~/.config/tmux/.tmux.conf"

    # git
    alias ga.="git add ."
    alias gcm="git commit -m"
    alias gp="git push"
    alias grs="git reset --soft HEAD~1"
    alias gs="git status"
    alias lg="lazygit"

    #kodius
    alias milivoje="ssh root@192.168.20.25"
    alias milivoje_vani="ssh root@185.155.224.196 -p 21222"
    alias serverina="ssh kodius@192.168.10.68"
    alias serverina_vani="ssh kodius@185.98.12.29 -p 22001"

    # ----------------------------- ALIAS ------------------------------

end

# ----------------------------- YAZI ------------------------------
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
# ----------------------------- YAZI ------------------------------

# Setting PATH for Python 3.11
# The original version is saved in /Users/dino/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

# pnpm
set -gx PNPM_HOME /Users/dino/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# add  default editor
set -g EDITOR nvim
set -g VISUAL nvim
