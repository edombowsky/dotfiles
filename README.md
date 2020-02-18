# Dotfiles Using Dotbot

Here be Dragons!

This repository contains files created by me to keep the following systems working the way I like them:

- Debian WSL
- Git Bash Windows 10
- MacOS

You should probably make your own repository, and put your dragons there.

Try bootstraping your dotfiles with [Dotbot](https://github.com/anishathalye/dotbot). If you want a template to get started, you can fork the [dotbot template][https://github.com/anishathalye/dotfiles_template] repo.

Making Local Customizations
You can make local customizations for some programs by editing these files:

vim : ~/.vimrc_local
zsh : ~/.zshrc_local_before run before .zshrc
zsh : ~/.zshrc_local_after run after .zshrc
git : ~/.gitconfig_local
tmux : ~/.tmux_local.conf

## Dependencies

- [liquidprompt](https://github.com/nojhan/liquidprompt): A full-featured & carefully designed adaptive prompt for Bash & Zsh
- [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt): An informative and fancy bash prompt for Git users
- [git-extras](https://github.com/tj/git-extras): Little git extras

## License

This software is hereby released into the public domain. That means you can do
whatever you want with it without restriction. See `LICENSE.md` for details.

That being said, I would appreciate it if you could maintain a link back to
Dotbot (or this repository) to help other people discover Dotbot.

