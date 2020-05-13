#*****************************************************
#*           ▄▄▄▄         ██                         *
#*           ▀▀██         ▀▀                         *
#*  ▄█████▄    ██       ████      ▄█████▄  ▄▄█████▄  *
#*  ▀ ▄▄▄██    ██         ██      ▀ ▄▄▄██  ██▄▄▄▄ ▀  *
#* ▄██▀▀▀██    ██         ██     ▄██▀▀▀██   ▀▀▀▀██▄  *
#* ██▄▄▄███    ██▄▄▄   ▄▄▄██▄▄▄  ██▄▄▄███  █▄▄▄▄▄██  *
#*  ▀▀▀▀ ▀▀     ▀▀▀▀   ▀▀▀▀▀▀▀▀   ▀▀▀▀ ▀▀   ▀▀▀▀▀▀   *
#*****************************************************
[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) Begin sourcing .bash_aliases..." \
    || echo "$( date +%T.%N%z ) Begin sourcing .bash_aliases..."

alias jdate='date +%j'

# Set the section search order for overlapping names
alias man='man -S 2:3:1:4:5:6:7:8'

# Let me have core dumps
ulimit -c unlimited

alias psef='ps -ef | head -1;  ps -ef | grep -v grep | grep --color=auto -i $1'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && alias ps="ps auxww" \
    || alias ps="ps auxf"

alias d='GLOBIGNORE=.; du -sch *; GLOBIGNORE=; shopt -u dotglob nullglob'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# A Perl REPL
alias perl-repl='perl -MData::Dumper -MTerm::ReadLine -e '\''$r = Term::ReadLine->new(1);while(defined($_ = $r->readline("code:  "))){$ret=Dumper(eval($_));$err=$@;if($err ne ""){print $err;}else{print $ret;}}'\'''

# directory tree - http://www.shell-fu.org/lister.php?id=209
# Will print the directory structure from the current directory in tree format.
alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# Calendar with today highlighted - http://www.shell-fu.org/lister.php?id=210
alias tcal='cal | sed "s/^/ /;s/$/ /;s/ $(date +%e) / $(date +%e | sed '\''s/./#/g'\'') /"'

# --------------------------------------------
# Give directory listings some colour
# --------------------------------------------
## Detect which `ls` flavour is in use
if ls --color > /dev/null 2>&1; then     # GNU `ls`
    colorflag="--color=auto"
    # Colours in Terminus were okay without any extra work
    if [ "${TERM_PROGRAM}" != "Terminus" ] && [ -z ${ALACRITTY_LOG+x} ]; then
        # [https://securitronlinux.com/bejiitaswrath/linux-mint-ubuntu-dircolors-command/]
        printf "Setting up DIR_COLORS"
        [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
        [ -e "$DIR_COLORS" ] || DIR_COLORS=""
        eval "$( dircolors -b $DIR_COLORS )"
    fi
else                                     # OS X `ls`
    colorflag="-G"
    # export LS_OPTIONS='--color=auto'
    export CLICOLOR=1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    # export LSCOLORS=ExFxBxDxCxegedabagacad
fi

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && alias ls="/bin/ls -CF ${colorflag}" \
    || alias ls="BLOCK_SIZE=\'1 /bin/ls -CFG ${colorflag}" #enable thousands grouping

alias lrt="ls -lrt ${colorflag}"
alias lart="ls -lart ${colorflag}"

# jeez I'm lazy ...
alias l='ls -l'
alias la='ls -a'
alias ll='ls -laF'
alias lla='ls -la'
alias lll='ls -la|less'
alias lsa='ls -ld .??*'                  # display long listing of only dot files
alias lsh='ls -d .??*'                   # display listing of only dot files
alias lsr='ls -R'
alias ldl='ls -ld .??*|less'             # display log listing of only dotfiles pagenated
alias lt='ls -lt'
alias ltl='ls -lt|less'
alias lr='ls -lR'
alias l.='ls -d .*'                      # list hidden files
alias ldot='ls -a | egrep "^\."'         # list hidden files in a directory
alias lz='ls -l | sort -bn +4'           # sort by files size in ascending order
alias lrz='ls -l | sort -bnr +4'         # sort by files size in descending order
alias ldir='ls -d */'                    # list only directories
alias lldir="ls -l | egrep '^d'"         # long listing of only directories
alias llf="ls -l | egrep -v '^d'"        # long listing of only files

alias sl=ls # often screw this up

# Navigate up the directory using "..n"
alias ..="cd .."                # go to parent directory
alias ..2="cd ../.."            # go to grandparent directory
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Tree
if [[ ! -x "$(which tree 2>/dev/null)" ]]; then
    alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# Misc :)
alias tf='tail -f '                    # continuous tail
alias whence='type -a'                 # where, of a sort
alias octal="stat -c '%A %a %n'"       # file permissions in octal
alias egrep='egrep --color=auto --exclude-dir=.svn --exclude-dir=.git'       # show differences in colour
alias fgrep='fgrep --color=auto --exclude-dir=.svn --exclude-dir=.git'       # show differences in colour
alias grep='grep --color --exclude-dir=.svn --exclude-dir=.git'              # show differences in colour

if [ -x "$(command -v fdfind)" ]; then
  echo 'Error: fdfind is not installed.' >&2
  alias fd=fdfind
fi

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Default to human readable figures
if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    alias df='df -h'
else
    # List our disk usage in human-readable units including filesystem type, and
    # print a total at the bottom:
    alias df='df -Tha --total'
fi
alias du='du -h'

# Make process table searchable. For example:
# psg bash
#
# USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# 1001      5227  0.0  0.0  26320  3376 pts/0    Ss   16:29   0:00 bash
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# File management
alias md='mkdir -pv'
alias rd=rmdir
alias ds='du -sk *(/)'
alias tailsf='tail -f'
alias mtail=multitail

# Terminal
alias cls='clear'
alias pd='pushd'
alias po='popd'
alias psa='ps -xedaf'

if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    alias off='pmset displaysleepnow'
    alias f='open -a Finder '
    alias fh='open -a Finder .'
    # Pin to the tail of long commands for an audible alert after long processes
    ## curl http://downloads.com/hugefile.zip; lmk
    alias lmk="say 'Process complete.'"
fi

## System information
[[ "${OSTYPE//[0-9.]/}" != "darwin" ]] \
    && alias sysinfo='landscape-sysinfo --exclude-sysinfo-plugins=LandscapeLink'

# changes the default head/tail behaviour to output x lines,
# where x is the number of lines currently displayed on your terminal
alias head='head -n $((${LINES:-12}-2))' #as many as possible without scrolling
alias tail='tail -n $((${LINES:-12}-2)) -s.1' #Likewise, also more responsive -f

if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    alias g="cd ~/Documents/Google\ Drive"
    alias dl="cd ~/Downloads"
    alias dt="cd ~/Desktop"
    alias p="cd ~/Documents/projects"
    alias vi=/usr/local/bin/vim

    # --------------------------------------------------------------------
    # Setup GCC (must be changes when updating to new major version)
    # --------------------------------------------------------------------
    alias g++='/usr/local/opt/gcc/bin/g++-7'
    alias gcc='/usr/local/opt/gcc/bin/gcc-7'
elif [[ "${OSTYPE//[0-9.]/}" = "linux-gnu" ]]; then
    alias c='cd /mnt/c'
    alias r='cd /mnt/d/repositories'
    alias vi=nvim
elif [[ "${OSTYPE//[0-9.]/}" = "msys" ]]; then
    alias c='cd /c'
    alias r='cd /c/Users/caeadom/Documents/projects'
    alias vi=nvim
fi

# what most people want from od (hexdump)
alias hd='od -Ax -tx1z -v'

# Repeat the last command with sudo prefixed
alias please='sudo $(fc -ln -1)'

#######################################
# Developer stuff
#######################################

# Checking library versions
# Run the following command to check whether the libraries are up to date:
alias vc='mvn versions:display-dependency-updates -U'

# Updating library versions
# Run the following command to update all ABB libraries
alias lu='mvn versions:update-properties -U'

## Epiphany cluster connections. Identity files are listed in ~/.ssh/config
alias dedev1='ssh dev1'
alias dedev2='ssh dev2'
alias dedev10='ssh dev10'
alias deperf1='ssh perf1'
alias deqa1='ssh qa1'
alias wfmint='ssh int'
alias wfmstg='ssh stg'

# -------------------------------
# Kubectl
# -------------------------------
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'
alias kgpan='kubectl get pods --all-namespaces'
alias kgdan='kubectl get deployments --all-namespaces'

# -------------------------------
# Docker
# -------------------------------
alias d=docker
alias dstats='d stats -a --no-stream'
alias dk='docker-compose'
alias drm="docker rm"
alias dirm="docker image rm"
alias dgc='docker rmi $(docker images -qf "dangling=true")'
# alias dps="docker ps -a"
alias dps='docker ps --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
alias dls='docker ps -a --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
alias di="docker image ls"
alias dim='docker images --format "table {{.Repository}}\\t{{.Tag}}\\t{{.ID}}\\t{{.Size}}\\t{{.CreatedSince}}"'
alias dv="docker volume ls"
alias dvc='docker volume ls -qf dangling=true | xargs docker volume rm'
alias dlog="docker logs"
alias dtail="docker logs --follow"
alias dstop="docker stop"
alias dexec="docker exec"
alias drmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
alias dtop='docker stats $(docker ps --format="{{.Names}}")'
alias dnet='docker network ls && echo && docker inspect --format "{{\$e := . }}{{with .NetworkSettings}} {{\$e.Name}}
{{range \$index, \$net := .Networks}}  - {{\$index}}    {{.IPAddress}}
{{end}}{{end}}" $(docker ps -q)'
alias dtag='docker inspect --format "{{.Name}}
{{range \$index, \$label := .Config.Labels}}  - {{\$index}}={{\$label}}
{{end}}" $(docker ps -q)'

alias sa='docker run -p 8080:8080/tcp --name admin --rm -d admin/caeadom/admincontainerservice:latest'
alias sadmin='docker run -p 8080:8080/tcp --name admin --rm -d'

# Kubernetes
alias k='kubectl'
alias kn='kubectl get namespaces'
alias kl='kubectl logs -f'
alias kd='kubectl describe pod'
alias kp='kubectl get pods'
alias kpg='kubectl get pods | grep -i'

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) End sourcing .bash_aliases..." \
    || echo "$( date +%T.%N%z ) End sourcing .bash_aliases..."

