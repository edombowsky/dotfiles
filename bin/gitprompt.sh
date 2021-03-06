#!/bin/bash
# gitprompt.sh by Christer Enfors -- http://github.com/enfors/gitprompt

GITPROMPT_VERSION="1.2.1"
RC_FILE=~/.gitpromptrc

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
RESET="\033[0m"
WHITE=$RESET
BLACK=$RESET

GIT_EXIT_STATUS_COLOR=$RED
GIT_TIME_COLOR=$RESET
GIT_BRACKET_COLOR=$BLUE
GIT_AT_COLOR=$RESET
GIT_USERNAME_COLOR=$GREEN
GIT_HOSTNAME_COLOR=$GREEN
GIT_HOSTALIAS_COLOR=$RESET
GIT_COLON_COLOR=$RESET
GIT_PWD_COLOR=$YELLOW
GIT_BRANCH_COLOR=$RESET

GIT_ADDED_COLOR=$YELLOW
GIT_UNTRACKED_COLOR=$CYAN
GIT_MODIFIED_COLOR=$BLUE
GIT_DELETED_COLOR=$RED
GIT_RENAMED_COLOR=$MAGENTA
GIT_COPIED_COLOR=$MAGENTA
GIT_UNMERGED_COLOR=$MAGENTA

#
# INIT FUNCTIONS
#

function Init
{
    EchoGreeting

    if [ ! -e $RC_FILE ]; then
    MkConfigFile
    echo "It seems like this is your first time using GitPrompt."
    echo "GitPrompt makes the prompt more informative, especially "
    echo "(but not only) if you use git."
    else
    ReadConfigFile
    fi

    SetEditor
}

function EchoGreeting
{
    echo "[GitPrompt version $GITPROMPT_VERSION by Christer Enfors enabled." \
     "Type 'GPHelp' for help.]"
}

function SetEditor
{
    if [ -z "$EDITOR" ]; then
    if [ -n "$VISUAL" ]; then
        EDITOR="$VISUAL"
    else
        if [ $(which nano) ]; then
        EDITOR="nano"
        else
        EDITOR="vi"
        fi
    fi
    fi
}

#
# USER COMMAND FUNCTIONS
#

function GPHelp
{
    cat <<EOF
GitPrompt help
==============
GitPrompt is a script which configures your prompt to be a little more
helpful; see https://www.github.com/enfors/gitprompt for details about
what it does.

GitPrompt commands
==================
GPConfig     - customize the colors of the prompt
GPReset      - reset the colors to the default
EOF
}

function GPConfig
{
    $EDITOR $RC_FILE

    if [ $? -ne 0 ]; then
    echo "Editing config file failed; aborting." >&2
    return 1
    fi

    ReadConfigFile
    SetPrompt
}

function GPReset
{
    MkConfigFile
    ReadConfigFile
    SetPrompt
}

#
# CONFIG FILE FUNCTIONS
#

function MkConfigFile
{
    if [ -e "$RC_FILE" ]; then
    echo -n "Do you want to reset your GitPrompt config? [y/N]: "
    read answer
    if [ "$answer" != "y" ]; then
        echo "Very well - it will be left as it is."
        return 0
    fi
    fi

    cat <<EOF >$RC_FILE
# This is the config file for GitPrompt.
#
# Color key:
#
# ,-----+------ GIT_BRACKET_COLOR -----------------+-------.
# |     |                                          |       |
# |     |   GIT_AT_COLOR                           |       |
# |     |        |                                 |       |
# |     |        |  GIT_COLON_COLOR                |       |
# |     |        |       |                         |       |
# V     V        v       V                         V       V
# [02:44] enfors @ shodan: ~/devel/shell/gitprompt [develop]: Modified
#    ^      ^        ^                 ^               ^
#    |      |        |                 |               |
#    |      |  GIT_HOSTNAME_COLOR   GIT_PWD_COLOR  GIT_BRANCH_COLOR
#    |      |
#    | GIT_USERNAME_COLOR
#    |
# GIT_TIME_COLOR

GIT_EXIT_STATUS_COLOR=\$RED
GIT_TIME_COLOR=\$RESET
GIT_BRACKET_COLOR=\$BLUE
GIT_AT_COLOR=\$RESET
GIT_USERNAME_COLOR=\$GREEN
GIT_HOSTNAME_COLOR=\$GREEN
GIT_HOSTALIAS_COLOR=\$RESET
GIT_COLON_COLOR=\$RESET
GIT_PWD_COLOR=\$YELLOW
GIT_BRANCH_COLOR=\$RESET

GIT_ADDED_COLOR=\$YELLOW
GIT_UNTRACKED_COLOR=\$CYAN
GIT_MODIFIED_COLOR=\$BLUE
GIT_DELETED_COLOR=\$RED
GIT_RENAMED_COLOR=\$MAGENTA
GIT_COPIED_COLOR=\$MAGENTA
GIT_UNMERGED_COLOR=\$MAGENTA
EOF
}

function ReadConfigFile
{
    . $RC_FILE
}

# Display the exit status of the previous command, if non-zero.
function ExitStatus
{
    gs_exitstatus=$?

    if [ $gs_exitstatus -ne 0 ]; then
    echo -en "${GIT_EXIT_STATUS_COLOR}Exit status: $gs_exitstatus $RESET"
    fi
}

function SetHostAlias
{
    if [ -n "$HOSTALIAS" ]; then
    hostalias="$GIT_BRACKET_COLOR[$GIT_HOSTALIAS_COLOR$HOSTALIAS$GIT_BRACKET_COLOR]$RESET"
    else
    hostalias=""
    fi
}

function SetPrompt
{
    SetHostAlias
    export PS1="\$(ExitStatus)$GIT_BRACKET_COLOR[$GIT_TIME_COLOR\$(date +%H:%M)$GIT_BRACKET_COLOR]$RESET $GIT_USERNAME_COLOR\u$GIT_AT_COLOR @ $GIT_HOSTNAME_COLOR\h$RESET$hostalias: $GIT_PWD_COLOR\w$RESET \$(GitStatus)\n\$ "
}

# This is called before printing the each word in a list. The words should be
# comma separated, so it prints a comma unless the word it's supposed to print
# next is the FIRST word.
function MaybeEchoComma
{
    if [ ! -z "$gs_first" ]; then
    gs_first=
    else
    echo -n ", "
    fi
}

# Show the git commit status.
function CommitStatus
{
    unset added
    git status -s --porcelain | while read -r line; do
    if [[ $line == A* ]]; then
        if [ -z "$added" ]; then
        added=1
        MaybeEchoComma
        echo -en "${GIT_ADDED_COLOR}Added${RESET}"
        fi
    elif [[ $line == \?\?* ]]; then
        if [ -z "$untracked" ]; then
        untracked=1
        MaybeEchoComma
        echo -en "${GIT_UNTRACKED_COLOR}Untracked${RESET}"
        fi
    elif [[ $line == M* ]]; then
        if [ -z "$modified" ]; then
        modified=1
        MaybeEchoComma
        echo -en "${GIT_MODIFIED_COLOR}Modified${RESET}"
        fi
    elif [[ $line == D* ]]; then
        if [ -z "$deleted" ]; then
        deleted=1
        MaybeEchoComma
        echo -en "${GIT_DELETED_COLOR}Deleted${RESET}"
        fi
    elif [[ $line == R* ]]; then
        if [ -z "$renamed" ]; then
        renamed=1
        MaybeEchoComma
        echo -en "${GIT_RENAMED_COLOR}Renamed${RESET}"
        fi
    elif [[ $line == C* ]]; then
        if [ -z "$copied" ]; then
        copied=1
        echo -en ", ${GIT_COPIED_COLOR}Copied${RESET}"
        fi
    elif [[ $line == U* ]]; then
        if [ -z "$unmerged" ]; then
        copied=1
        MaybeEchoComma
        echo -en "${GIT_UNMERGED_COLOR}Updated-but-unmerged${RESET}"
        fi
    else
        echo "UNKNOWN STATUS"
        return 1
        fi
    done

    return 0
}

function GitStatus
{

    gs_first=1

    # If we're inside a .git directory, we can't find the branch / commit status.
    if pwd | grep -q /.git; then
    return 0
    fi

    if git rev-parse --git-dir >/dev/null 2>&1; then
    gs_branch=$(git branch | grep "^* " | cut -c 3-)

    gs_gitstatus=$(CommitStatus)

    if [ $? -eq 0 ]; then
        if [ -z "$gs_gitstatus" ]; then
        echo -e "$GIT_BRACKET_COLOR[$GIT_BRANCH_COLOR$gs_branch$GIT_BRACKET_COLOR]$RESET: ${GREEN}Up-to-date${RESET}"
        else
        echo -e "$GIT_BRACKET_COLOR[$GIT_BRANCH_COLOR$gs_branch$GIT_BRACKET_COLOR]$RESET: $gs_gitstatus"
        fi
    fi
    fi
}

function Main
{
    Init
    SetPrompt
}

Main


