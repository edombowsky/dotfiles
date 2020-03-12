# If not running interactively, don't do anything
[[ $- == *i* ]] || return
# case $- in
#     *i*) ;;
#       *) return;;
# esac

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) Begin sourcing .bashrc..." \
    || echo "$( date +%T.%N%z ) Begin sourcing .bashrc..."

# --------------------------------------------------------------------
# General options
# --------------------------------------------------------------------
set bell-style none

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=0

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Immediately add a trailing slash when auto-completing symlinks to directories
bind "set mark-symlinked-directories on"

# Turn on recursive globbing (enables ** to recurse all directories and subdirectories)
shopt -s globstar 2> /dev/null

# --------------------------------------------------------------------
# nnn configuration
# --------------------------------------------------------------------
export NNN_PLUG='o:fzopen;d:diffs;p:-_less -iR $nnn;g:_git log;e:suedit;h:hexview'
export NNN_SHOW_HIDDEN=1

# --------------------------------------------------------------------
# Smarter TAB completion (Readline bindings)
# --------------------------------------------------------------------
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# -------------------------------------------
# bash command line completion
# -------------------------------------------
if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
else
    # Enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi
fi

# A colon-separated list of suffixes to ignore when performing filename completion.
# A file name whose suffix matches one of the entries in FIGNORE is excluded from
# the list of matched file names.
FIGNORE=$FIGNORE:DS_Store:.o:~:.iml:.class

# --------------------------------------------------------------------
# Better directory navigation
# --------------------------------------------------------------------
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
case "${OSTYPE//[0-9.]/}" in
    "msys") CDPATH=".:~:/c/Users/caeadom/Documents/projects" ;;      # git-bash
    "linux-gnu") CDPATH=".:~:/mnt/d/repositories" ;;       # wsl
    "darwin") CDPATH=".:~:/Users/caeadom/Documents/projects/" ;;          # mac-os
esac

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# --------------------------------------------------------------------
# Sane history defaults
# --------------------------------------------------------------------
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace (ignoreboth => both options)
HISTCONTROL=ignoreboth:erasedups

# Save multi-line commands as one command
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# Don't record some commands
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
HISTIGNORE="&:[ \t]*:exit:ls:[bf]g:history:clear:ps:cd ~:cd ..:--:pwd:clear:reset:h"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '
#HISTTIMEFORMAT="%h %d %H:%M:%S> "

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# --------------------------------------------------------------------
# Customise less
# --------------------------------------------------------------------
# export LESS="-cisQMgRwPmFX -Pm<--Less--> -PM?f%f:<stdin>. ?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t\$"
# export LESS="-cisQMgFRw -Pm<--Less--> -PM?f%f:<stdin>. ?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t\$"
export LESS="-cisQMgRw -PM?n?f%f .?m(file %i of %m) ..?e(End) ?x- Next\: %x.: ?pB%pB\%:byte %bB?s/%s...%t ?f%f .?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(End) ?x- Next\: %x.:?pB%pB\%..%t\$"
export LESSKEY=${HOME}/.less_${OS}
export LESSBINFMT='*u[%X]'  # Underline non-printable characters and print them in hex inside square brackets
export LESSEDIT="%E --no-wait ?lm+%lm. %f"
export LESSSECURE=1
# export PAGER="less -cisQMgRw  -PM'<man page> ?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END):?pB%pB\%..%t'"
# export PAGER="less -s  -PM'<man page> ?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END):?pB%pB\%..%t'"
export PAGER=less

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --------------------------------------------------------------------
# Customise ripgrep
# --------------------------------------------------------------------
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# --------------------------------------------------------------------
# Customise the prompt
# --------------------------------------------------------------------
[[ -f ~/.bash_prompts ]] && source ~/.bash_prompts

if [[ -f "$HOME/liquidprompt/liquidprompt1" ]]; then    # liquidprompt seemed too slow so for now don't use it
    setup_liquidprompt
elif [[ "${OSTYPE//[0-9.]/}" = 'darwin' && -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]]; then
    setup_magicmonty_prompt
elif [[ -f "$HOME/bin/bash-git-prompt/gitprompt.sh" ]]; then
    setup_magicmonty_prompt
elif [[ -f "~/.git-prompt.sh" ]]; then
    setup_git-prompt
fi

# --------------------------------------------------------------------
# Neovim configuration
# --------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --------------------------------------------------------------------
# Azure CLI 2.0 settings
# --------------------------------------------------------------------
pathmunge $HOME/bin before; export PATH
[ -s "/home/user/lib/azure-cli/az.completion" ] && source "/home/user/lib/azure-cli/az.completion"

# --------------------------------------------------------------------
# Aliases and functions
# --------------------------------------------------------------------
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) End sourcing .bashrc..." \
    || echo "$( date +%T.%N%z ) End sourcing .bashrc..."

