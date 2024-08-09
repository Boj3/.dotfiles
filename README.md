
# Arch Linux Installation and Setup Guide

This guide will walk you through the installation and configuration of Arch Linux with arch linux, tmux, nvim, bspwm, polybar ...

## 1. Load French Keyboard Layout

`loadkeys fr`

## 2. Install Arch Linux

Use the `archinstall` script to simplify the installation process:

Select the following options during the installation:

-   **Type**: Desktop
-   **Profile**: Minimal KDE Plasma

## 3. Install Firefox

Once KDE Plasma is installed and you're logged in:

`sudo pacman -S firefox` 

## 4. Install Essential Dependencies

Install the necessary dependencies and tools:

`sudo pacman -S --needed base-devel zsh git alacritty polybar rofi arc-gtk-theme papirus-icon-theme feh picom nerd-fonts xorg-server xorg-xinit xorg-xsetroot xorg-xrandr neovim xsettingsd bspwm sxhkd lightdm lightdm-gtk-greeter dunst bat exa starship nodejs npm unzip fuse curl tree ripgrep fzf neofetch xclip zsh tmux thefuck zoxide eza fd stow` 

## 5. Install and Configure `yay` (AUR Helper)

Clone and install `yay` to manage AUR packages:

`git clone https://aur.archlinux.org/yay.git &&
sudo chown -R $(whoami):$(whoami) yay &&
cd yay &&
makepkg -si` 

### Install Additional Packages with `yay`

`yay -S picom-arian8j2-git google-chrome` 

## 6. Clone and Apply Dotfiles

Clone your dotfiles repository and apply the configurations using `stow`:

`git clone https://github.com/Boj3/.dotfiles.git && 
cd ~/.dotfiles && 
chmod +x setup.sh &&
./setup.sh `

## 7. Install Node.js and Angular CLI

Install Node.js and the Angular CLI globally:

`sudo npm install -g @angular/cli` 

## 8. Install Oh My Zsh

Set up and configure `Oh My Zsh`:

`sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` 

### Add Zsh Plugins

Clone and add useful Zsh plugins:

`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions` 

## 9. Install and Configure Tmux Plugin Manager (TPM)

Set up the Tmux Plugin Manager:

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` 

## 10. Install and Configure fzf

Clone and install `fzf`:

`git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install` 

### Add fzf Git Integration

`git clone https://github.com/junegunn/fzf-git.sh.git` 

