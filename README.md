# dotfiles #

Here lies a dotfiles git repo

The easiest way to use these dotfiles is to use the install script. For more info check out [this link](https://www.atlassian.com/git/tutorials/dotfiles)

`curl -Lks https://gitlab.com/snippets/1990795/raw | /bin/bash`

# Dependencies #

Obviously, a if you want to use a dotfile, you need the program it goes with. This is a list of packages not included in the program which need to be installed.

## nvim ##

- python-pynvim

    If pynvim is not in your repo, you can install it with
    ```
    pip2 install neovim
    pip3 install neovim
    ```

## xbindkeys (mouse button remap)

- xbindkeys
- xautomation
- xev

## Qt theme loading from gtk
- qt5-styleplugins
