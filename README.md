# My 💤 LazyVim IDE config for Neovim

[![IT Man - Talk #33 NeoVim as IDE [Vietnamese]](https://i.ytimg.com/vi/dFi8CzvqkNE/hqdefault.jpg)](https://www.youtube.com/watch?v=dFi8CzvqkNE)

[![IT Man - Talk #35 #Neovim IDE for Web Developer](https://i.ytimg.com/vi/3EbgMJ-RcWY/hqdefault.jpg)](https://www.youtube.com/watch?v=3EbgMJ-RcWY)

## Install Neovim

The easy way is using [MordechaiHadad/bob: A version manager for neovim](https://github.com/MordechaiHadad/bob).

```sh
bob install stable
bob use stable
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/jellydn/lazy-nvim-ide.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

## Get healthy

Open `nvim` and enter the following:

```lua
:checkhealth
```

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Try with Docker

```sh
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs npm neovim ripgrep build-base make musl-dev go --update
  go install github.com/jesseduffield/lazygit@latest
  git clone https://github.com/jellydn/lazy-nvim-ide ~/.config/nvim
  nvim
  '
```

## Uninstall

```sh
  rm -rf ~/.config/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.cache/nvim
  rm -rf ~/.local/state/nvim
```

## Screenshots

<img width="1792" alt="image" src="https://user-images.githubusercontent.com/870029/228557089-0faaa49f-5dab-4704-a919-04decfc781ac.png">

## Tips

- Improve key repeat on Mac OSX, need to restart

```sh
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 14
```

- VSCode on Mac

To enable key-repeating, execute the following in your Terminal, log out and back in, and then restart VS Code:

```sh
# For VS Code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# For VS Code Insider
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
# If necessary, reset global default
defaults delete -g ApplePressAndHoldEnabled
# For Cursor
defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false
```

Also increasing Key Repeat and Delay Until Repeat settings in System Preferences -> Keyboard.

[![Key repeat rate](https://i.gyazo.com/e58be996275fe50bee31412ea5930017.png)](https://gyazo.com/e58be996275fe50bee31412ea5930017)
