[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) Begin sourcing .bash_functions..." \
    || echo "$( date +%T.%N%z ) Begin sourcing .bash_functons..."

# taken from https://github.com/matthewmccullough/dotfiles/blob/master/shellaliases
matrix() {
    echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

# Useful command for stripping whitespace
remove_trailing_whitespace() {
    find . -name $* -exec sed -i '' -e's/[[:space:]]*$//' {} \;
}

# Get colours in manual pages
function man() {
    env \
       LESS_TERMCAP_mb=$(printf "\e[1;31m") \
       LESS_TERMCAP_md=$(printf "\e[1;31m") \
       LESS_TERMCAP_me=$(printf "\e[0m") \
       LESS_TERMCAP_se=$(printf "\e[0m") \
       LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
       LESS_TERMCAP_ue=$(printf "\e[0m") \
       LESS_TERMCAP_us=$(printf "\e[1;32m") \
           man "$@"
}

_checkexec() {
    command -v "$1" > /dev/null
}

# delete the previous command from history
forget() { 
    history -d $( history | awk 'END{print $1-1}' ); 
}

## --------------------------------------------------
## Path related commands
## --------------------------------------------------
## List path in a one-element per line format
path() { tr ':' '\n' <<< "$PATH"; }
# path() { echo -e ${PATH//:/\\n} }

path_remove() {
    PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' |sed 's/:$//')
}

path_append() {
    path_remove "$1"
    PATH="${PATH:+"$PATH:"}$1"
}

path_prepend() {
    path_remove "$1"
    PATH="$1${PATH:+":$PATH"}"
}

# Search for a running process
task () { ps axuf | grep -v grep | grep "$@" -i --color=auto; }

# Creates an archive (*.tar.gz) from given directory
maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder
makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Find all files with Unix line endings (LF)
findlf () {
  find . -not \( \
    -name .git -prune -o \
    -name .idea -prune -o \
    -name node_modules -prune \
  \) -type f -print0 | xargs -0 unix2dos -ic
}

# Convert all files with Unix line endings (LF) into Windows line endings (CRLF)
convertlf () {
  find . -not \( \
    -name .git -prune -o \
    -name .idea -prune -o \
    -name node_modules -prune \
  \) -type f -print0 | xargs -0 unix2dos -ic | xargs -d '\n' unix2dos
}

# Find all files with Windows line endings (CRLF)
findcrlf () {
  find . -not \( \
    -name .git -prune -o \
    -name .idea -prune -o \
    -name node_modules -prune \
  \) -type f -print0 | xargs -0 dos2unix -ic
}

# Convert all files with Windows line endings (CRLF) into Unix line endings (LF)
convertcrlf () {
  find . -not \( \
    -name .git -prune -o \
    -name .idea -prune -o \
    -name node_modules -prune \
  \) -type f -print0 | xargs -0 dos2unix -ic | xargs -d '\n' dos2unix
}

## Mirror stdout to stderr, useful for seeing data going through a pipe
alias peek='tee >(cat 1>&2)'

## go to previous directory
--() { cd -; }

mt() { multitail -n 1000000 $@; }

# Copy a file to the current directory with today's date automatically appended to the end
bu() { cp "$1" "$1".backup-`date +%Y%m%d.%H%M%S`; }

# Calculates the gzip compression of a file
gzipsize() { echo $((`gzip -c $1 | wc -c`/1024))"KB"; }

# Copy a file to the current directory with todays date automatically appended to the end
function bu { cp "$1" "$1".backup-`date +%Y%m%d.%H%M%S`; }

if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    # Beyond Comapre
    bcompare() { /usr/local/bin/bcomp $* &> /dev/null & }
    alias extend_bcomp='rm /Users/caeadom/Library/Application\ Support/Beyond\ Compare/registry.dat'

    listening() {
        if [ $# -eq 0 ]; then
            sudo lsof -iTCP -sTCP:LISTEN -n -P
        elif [ $# -eq 1 ]; then
            sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
        else
            echo "Usage: listening [pattern]"
        fi
    }

    alias listen-portd='lsof -nP -iTCP -sTCP:LISTEN'
fi

# Make these functions, common in other languages, available in the shell
ord() { printf "0x%x\n" "'$1"; }
chr() { printf $(printf '\\%03o\\n' "$1"); }

title() {
    # sends xterm escape sequence to change window title to first command line
    # argument if present, otherwise, use $PWD

    esc="\e" # \033
    bel="\a" # \007

    txt=${1:$PWD}

    echo -en "${esc}]2;${txt}${bel}"
}

set_win_title() {
    echo -ne "\033]0;${PWD##*/}\007"
}

# Sort du output in Human-readable format (http://www.bashoneliners.com/oneliners/97/)
#
# The reason to use a for loop is to sort results with G or M or K values
# separately, otherwise sort -n would just sort everything by the numbers
# regardless of G M K suffix.
#
# grep "[0-9]$i\b" matches lines containing a digit followed by G or M or K
# followed by a "word boundary"
duh() {
    for i in G M K; do du -hsx * | grep "[0-9]$i\b" | sort -nr; done 2>/dev/null
    # du -hsx * | sort -rh
}

#
# Print the complete command line history.  If you type
#
#    h ls
#
# it'll give you all the history related to the command ls.  If it does
# not follow an argument, then the function shows normal history of
# :history 1" which is to list the history from the 1st command.
#
h() { if [ -z "$*" ]; then history; else history | egrep "$@"; fi; }

# We know we can repeat the last command starting with a specified word,
# for example: !vi (bash) or r vi (ksh).
# Sometimes I need to look for a file object of the command and not for the
# command itself; so I wrote a little function.  Its execution is simple:
#
# $ cmd [<to_find>] [<tail_element>]
#
# If you run cmd alone you pick one of the last commands except "cmd" itself
# from the last 10 lines of the history file.
#
# $ cmd
#
# If you specify the <to_find> variable you pick all the commands matching
# your criteria
#
# $ cmd bash
#
# If you specify <tail_element> option and <to_find> variable you pick all
# the command matching your criteria in the last <tail_element> rows
#
# $ cmd bash 30
cmd() {
   history | tail -${2:-10} | awk -v tofind=${1:-[0-9]} '($0!~/ cmd /) &&
   ($0~tofind) { print }'

}

# Find the most commonly used commands from your history
mcu() {
    history | \
    awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | \
    grep -v "./" | column -c3 -s " " -t | \
    sort -nr | \
    nl |  \
    head -n10
}

mcu1() {
    history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $5}' | sort | uniq -c | sort -nr | head -n10
}

mcu2() {
    history | awk '{a[$4]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

mcu3() {
    history | awk '{print $4}' | sort  | uniq --count | sort --numeric-sort --reverse | head -n10
}

weather() {
    (( ! $# )) && echo You need to supply a location! && return 1

    curl http://wttr.in/$1?m
}

#######################################
# Developer stuff
#######################################

# ripgrep functions
rj() { rg --type java "$@"; }
rs() { rg --type scala "$@"; }
rx() { rg --type xml "$@"; }
rjsi() { rg --type js "$@"; }

# The function takes one argument, for which it searches for directories inside
# all subfolders of the root repo folder (~/repos), and returns the first result,
# if there is one. So repo dotfiles or even repo dot will result in navigating to
# ~/repos/personal/dotfiles, and repo kalis will navigate to ~/repos/personal/kalis.me.
repo() {
    case "${OSTYPE//[0-9.]/}" in
        "darwin") repo_base="/Users/caeadom/Documents/projects/" ;;
        "linux-gnu") repo_base="/mnt/d/repositories" ;;
        "msys") repo_base=/c/Users/caeadom/Documents/projects/ ;;
    esac

    if [[ -z "${1}" ]]; then
        echo "repo not found so go to $repo_base"
        cd "$repo_base"
    else
        repo_path=$(find "$repo_base" -maxdepth 4 -type d -name "*$1*" | head -n 1)
        if [[ -z "${repo_path}" ]]; then
            echo "repo not found so go to $repo_base"
            cd "$repo_base"
        else
            echo "found $repo_path"
            cd "$repo_path"
        fi
    fi
}

#       -Dnoauth \
#       -DMemoryLock=false \
#       -DDebugging \

# Used to create AdminContainerService docker container (It's WFM so needs Java 1.8)
install_wfm() {
    [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
        && JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk/Contents/Home \
        || JAVA_HOME=/usr/lib/jvm/jdk1.8.0_221
    PATH=$JAVA_HOME/bin:$PATH
    mvn install \
        -Dmaven.test.skip=true \
        -DAzureContainerFolder=admin/caeadom \
        -Dnoauth | tee install.log
}

refresh_all() {
    CURRDIR=$PWD
    [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
        && cd /Users/caeadom/Documents/projects/wfm \
        || cd /home/user/Documents/wfm

    for f in *; do
        if [ -d ${f} ]; then
            # Will not run if no directories are available
            if [[ "${f}" != "_wfm" ]]; then
                printf "\n******** Refreshing $f ********\n"
                cd $f
                THE_GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
                if [[ "$THE_GIT_BRANCH" == "master" ]]; then
                    git refresh
                else
                    printf "$THE_GIT_BRANCH is not master, update manually...\n\n"
                fi
                cd ..
            fi
        fi
    done

    cd $CURRDIR
}

# Print the list of your Git commits this month
# Explanation
# --since='last month' sets the start of the period, in this case the end of the
#                      previous month. Other interesting examples: midnight,
#                      2 weeks ago. When the date parameter contains a space,
#                      it must be quoted, naturally.
# --author="$(git config user.name)" filters commits matching a specific author,
#                                    in this example yourself, looking up your
#                                    full name from your Git configuration.
# --oneline makes the output compactly one line per commit
mth() {
    git log --since='last month' --author="$(git config user.name)" --oneline
}

# List packages in a jar file
jarpkgs() {
    jar tf $1 | grep class$ | perl -pe "s|/[^/]*class$||;s|/|.|g" | sort | uniq
}

dsh() {
    docker exec -it $1 bash
}

dremove() {
  local name=$1
  local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

  if [[ "$state" == "false" ]]; then
    docker rm $name
  fi
}

delstop() {
  local name=$1
  local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

  if [[ "$state" == "true" ]]; then
    docker stop $name
    docker rm $name
  fi
}

# print the corresponding error message
strerror() {
    python -c "import os,locale as l; l.setlocale(l.LC_ALL, ''); print os.strerror($1)";
}

if [[ "${OSTYPE//[0-9.]/}" = 'linux-gnu' ]]; then
    vscode() {
        if [[ "$#" -ne 1 ]]; then
            code 2>&1 >/dev/null &
        else
            code $(wslpath -w "$1") 2>&1 >/dev/null &
        fi
    }
fi

if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    jdk8() {
        export JAVA_HOME=/Library/Java/JavaVirtualMchines/jdk1.8.0_221.jdk/Contents/Home
        pathmunge $JAVA_HOME/bin before; export PATH
    }
else
    # translate to linux path from windows path
    windir() {
        echo "$1" | sed -e 's|^\([a-z]\):\(.*\)|/mnt/\L\1\E\2|' -e 's|\\|/|g'
    }

    # translate the path back to windows path
    wsldir() {
        echo "$1" | sed -e 's|^/mnt/\([a-z]\)/\(.*\)|\U\1\:\\\E\2|' -e 's|/|\\|g'
    }
fi

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) End sourcing .bash_functions..." \
    || echo "$( date +%T.%N%z ) End sourcing .bash_functions..."
