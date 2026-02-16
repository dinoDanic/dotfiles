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

    # tmux
    alias tc="nvim ~/.config/tmux/.tmux.conf"

    alias lla="ll -a"

    # git
    alias ga.="git add ."
    alias gcm="git commit -m"
    alias gp="git push"
    alias grs="git reset --soft HEAD~1"
    alias gs="git status"
    alias lg="lazygit"

    alias fc="nvim ~/.config/fish/config.fish"
    alias zc="nvim ~/.config/zellij/config.kdl"
    alias hyp="nvim ~/.config/hypr/bindings.conf"

    #kodius
    alias milivoje="ssh root@192.168.20.25"
    alias milivoje_vani="ssh root@185.155.224.196 -p 21222"
    alias serverina="ssh kodius@192.168.10.68"
    alias serverina_vani="ssh kodius@185.98.12.29 -p 22001"

    alias claude_yolo="claude --dangerously-skip-permissions"
    alias weather="curl wttr.in/sveti-ivan-zelina"

    # ----------------------------- ALIAS ------------------------------

end


# ----------------------------- CUSTOM ------------------------------
function _read_or --argument path fallback
    if test -r $path
        cat $path
    else
        echo $fallback
    end
end

function _read_or --argument path fallback
    if test -r $path
        cat $path
    else
        echo $fallback
    end
end


function pp
    ~/.config/fish/scripts/pp.sh
end

# ----------------------------- PATHS ------------------------------

set -gx ANDROID_HOME $HOME/Android/Sdk
set -x PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH $PNPM_HOME $PATH
set -Ux ANDROID_AVD_HOME $HOME/.config/.android/avd
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.local/share/gem/ruby/3.4.0/bin $PATH
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

# opencode
fish_add_path /home/dino/.opencode/bin

