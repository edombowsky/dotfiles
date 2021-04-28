# Dotfiles Using Dotbot

Here be Dragons!

This repository contains files created by me to keep the following systems working the way I like them:

- Ubuntu WSL = zsh
- Git Bash Windows 10 - bash`
- MacOS - zsh

You should probably make your own repository, and put your dragons there.

Try bootstrapping your dotfiles with [Dotbot](https://github.com/anishathalye/dotbot). If you want a template to get started, you can fork the [dotbot template][https://github.com/anishathalye/dotfiles_template] repo.

## Installing

Dotbot makes installing your dotfiles as easy as `git clone $url && cd dotfiles && ./install`, even on a freshly installed system!

### Prepare repository sub-modules

```bash
cd vim
mkdir -p pack/tpope/start
cd vim/pack/tpope/start
git submodule add git@github.com:tpope/vim-fugitive.git

cd vim
mkdir bundle
cd bundle
git submodule add git@github.com:VundleVim/Vundle.vim.git
git submodule add git@github.com:vim-airline/vim-airline.git
git submodule add git@github.com:vim-airline/vim-airline-themes.git
```

### Maintaining submodules at latest commits

```bash
git submodule foreach git pull origin master

# Now the submodules are in the state you want, so
git commit -am "Pulled down update to sub-modules"

# A quicker method is the following that will fetch the latest changes from 
# upstream in each submodule, merge them in, and check out the latest revision
# of the submodule
git submodule update --remote --merge
```

### Prepare prompt modules

- Homebrew: `brew install starship`
- Scoop: `scoop install starship`

### Multiple targets

I have utilised the method outlined in the following [pull request](https://github.com/anishathalye/dotbot/pull/11) discussion to support multiple targets.

### Dependencies

- [dotbot](https://github.com/anishathalye/dotbot): A tool that bootstraps your dotfiles

#### Bash prompts

- [oh-my-posh](https://ohmyposh.dev)

#### Zsh prompts

- [oh-my-posh](https://ohmyposh.dev)

#### Vim/Nvim plugins

- [Vundle](https://github.com/VundleVim/Vundle.vim): Plug-in manager for Vim
- [vim-airline](https://github.com/vim-airline/vim-airline): lean & mean status/tabline for vim that's light as air
- [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes): A collection of themes for vim-airline
- [vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal
- [inkpot](https://github.com/ciaranm/inkpot): Inkpot 88/256 Colour Scheme for Vim

#### Extras

- [git-extras](https://github.com/tj/git-extras): Little git extras
  + Install on mac with 

    ```zsh
    brew install git-extras
    ```

  + Install on windows without

    ```shell
    git clone https://github.com/tj/git-extras.git
    # checkout the latest tag (optional)
    git checkout $(git describe --tags $(git rev-list --tags --max-count=1))

    install.cmd "C:\git"
    ```

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Fish-like autosuggestions for zsh
  + Install on mac with

    ```bash
    brew install zsh-autosuggestions`
    ```

## License

This software is hereby released into the public domain. That means you can do whatever you want with it without restriction. See `LICENSE.md` for details.

That being said, I would appreciate it if you could maintain a link back to Dotbot (or this repository) to help other people discover Dotbot.
