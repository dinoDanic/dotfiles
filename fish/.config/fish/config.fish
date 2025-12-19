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


    # neovim
    alias nc="cd ~/.config/nvim && nvim"
    alias n="nvim"

    # globals
    alias h="history"

    # alacritty 
    alias ac="nvim ~/.config/alacritty/alacritty.toml"

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

# add  default editor
set -g EDITOR nvim
set -g VISUAL nvim
