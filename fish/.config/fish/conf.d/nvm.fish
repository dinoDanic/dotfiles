# nvm radi samo u bashu - dodaj najnoviju instaliranu Node verziju u PATH
if test -d ~/.nvm/versions/node
    set -l v (path basename ~/.nvm/versions/node/* | sort -V | tail -1)
    fish_add_path -g ~/.nvm/versions/node/$v/bin
end
