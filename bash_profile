[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) Begin sourcing .bash_profile..." \
    || echo "$( date +%T.%N%z ) Begin sourcing .bash_profile..."

# Settings in this file are only for interactive shells.
# I don't know why bash loads this file for scp etc.,
# but return if that's the case.
[ "$PS1" ] || return

# In case this is not set which is likely in git-bash
${XDG_CONFIG_HOME=$HOME/.config}

#|+++++++++++++++++++++++++++++++++++++
#| Permissions encoding used by umask |
#|+++++++++++++++++++++++++++++++++++++
#|  Octal  |  Binary  |  Permissions  |
#|====================================|
#|    0    |   000    |      rwx      |
#|    1    |   001    |      rw-      |
#|    2    |   010    |      r-x      |
#|    3    |   011    |      r--      |
#|    4    |   100    |      -wx      |
#|    5    |   101    |      -w-      |
#|    6    |   110    |      --x      |
#|    7    |   111    |    (none)     |
#|+++++++++++++++++++++++++++++++++++++
umask 022

export BASE_MAVEN_OPTS="-Xmx1G"

# Munge the PATH variable. Will not add duplicates and you can add
# before or after PATH.
#
# Example:   pathmunge /usr/local/opt/sqlite/bin before; export PATH
#
pathmunge() {
    case ":${PATH}:" in
        *:"$1":*)
            # case is equivalent to
            # if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
            printf "Suppressed adding a duplicate to PATH [$1]\n"
            ;;

        *)
            if [ -d "$1" ]; then
                if [ "$2" = "after" ] ; then
                    printf "Adding [$1] after PATH\n"
                    PATH=$PATH:$1
                else
                    printf "Adding [$1] before PATH\n"
                    PATH=$1:$PATH
                fi
            else
                printf "Skipped adding [$1] to PATH as it does not exist\n"
            fi
            ;;
    esac
}

# function to avoid adding duplicate entries to the LD_LIBRARY_PATH
ldpathmunge() {
    case ":${LD_LIBRARY_PATH}:" in
        *:"$1":*)
            printf "Suppressed adding a duplicate to LD_LIBRARY_PATH [$1]"
            ;;
        *)
            if [ "$2" = "after" ] ; then
                LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$1
            else
                LD_LIBRARY_PATH=$1:$LD_LIBRARY_PATH
            fi
            ;;
    esac
}

# function to avoid adding duplicate entries to the MANPATH
manpathmunge() {
    case ":${MANPATH}:" in
        *:"$1":*)
            printf "Suppressed adding a duplicate to MANPATH [$1]"
            ;;
        *)
            if [ "$2" = "after" ] ; then
                MANPATH=$MANPATH:$1
            else
                MANPATH=$1:$MANPATH
            fi
            ;;
    esac
}

# All  of the above munge functions could be replaced by the following:
# function to avoid adding duplicate entries to a "path" or any shell
# variable for that matter
#
# Usage:
#
#   pathmunge PATH ~/bin
#   pathmunge MANPATH /usr/local/man after
#
#  Note the "declare -n" wasn't introduced until GNU bash 4.3
# pathmunge () {
#     declare -n thepath=$1
#     case ":${thepath}:" in
#         *:"$2":*)
#             ;
#         *)
#             if [ "$3" = "after" ] ; then
#                 thepath=$thepath:$2
#             else
#                 thepath=$2:$thepath
#             fi
#             ;;
#     esac
# }

pathmunge $HOME/.local/bin after; export PATH
pathmunge $HOME/bin before; export PATH

realpath() {
    if ! pushd $1 &> /dev/null; then
        pushd ${1##*/} &> /dev/null
        echo $( pwd -P )/${1%/*}
    else
        pwd -P
    fi
    popd > /dev/null
}

removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

# -------------------------------------
# Proxy settings
# -------------------------------------
#export PROXY_SERVER=access618.cws.sco.cisco.com
#export PROXY_SERVER_PORT=8080
export PROXY_SERVER=geo-cluster125184-swg.ibosscloud.com
export PROXY_SERVER_PORT=8082

proxy() {
    if [ -z "$1" ]; then
        OUTPUT=$(env | grep -i http_proxy | grep -vi no_proxy | wc -l)
        if [ "$OUTPUT" -gt 0 ]; then
            echo "Proxy seems to be ON"
        else
            echo "Proxy seems to be OFF"
        fi
    elif [ "${1,,}" = "on" ]; then
        proxyon
        echo "Turned proxy ON"
    elif [ "${1,,}" = "off" ]; then
        proxyoff
        echo "Turned proxy OFF"
    elif [ "${1,,}" = "list" ]; then
        env | grep -i proxy | grep -vi no_proxy
    else
        echo "Don't understand $1, must be on/off/list/or empty"
    fi
}

proxyon() {
    unset {http,https,ftp,socks}_proxy
    unset {HTTP,HTTPS,FTP,SOCKS}_PROXY

    export {HTTP,HTTPS,SOCKS}_PROXY=http://${PROXY_SERVER}:${PROXY_SERVER_PORT}/
    export {http,https,socks}_proxy=http://${PROXY_SERVER}:${PROXY_SERVER_PORT}/
    export ftp_proxy=ftp://${PROXY_SERVER}:${PROXY_SERVER_PORT}/
    export FTP_PROXY=ftp://${PROXY_SERVER}:${PROXY_SERVER_PORT}/

    export MAVEN_OPTS="$BASE_MAVEN_OPTS -Dhttp.proxyHost=${PROXY_SERVER} -Dhttp.proxyPort=${PROXY_SERVER_PORT} -Dhttps.proxyHost=${PROXY_SERVER} -Dhttps.proxyPort=${PROXY_SERVER_PORT}"
}

proxyoff() {
    unset {http,https,ftp,socks}_proxy
    unset {HTTP,HTTPS,FTP,SOCKS}_PROXY

    export MAVEN_OPTS="$BASE_MAVEN_OPTS"
}

noproxy() {
    export no_proxy=localhost,127.0.0.0/8,*.abb.com,::1,10.*.*.*,wttr.in
    export NO_PROXY=localhost,127.0.0.0/8,*.abb.com,::1,10.*.*.*,wttr.in
}

# Turn proxy on by default
#proxyon
noproxy

# -------------------------------
# Docker settings
# -------------------------------
[[ "${OSTYPE//[0-9.]/}" != 'darwin' ]] && export DOCKER_HOST=tcp://localhost:2375

# #######################################
## DEVELOPMENT SETTINGS
# #######################################

# -------------------------------
# JAVA settings
#---------------------------------
if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    ## [How to Set $JAVA_HOME environment variable on Mac OS X](https://www.mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/)
    # Mac: http://www.mkyong.com/java/how-to-set-java_home-environment-variable-on-mac-os-x/
    # http://stackoverflow.com/questions/15826202/where-is-java-installed-on-mac-os-x
    # Either set JAVA_HOME as shown below when changing java versions or update
    # the symbolic link in /Library/Java to point to the new directory. For example.
    # sudo /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home Home
    # and use the second JAVA_HOME export
    #export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home
    export JAVA_HOME=$(/usr/libexec/java_home)

    ## After updating to IDEA 2017.1 EAP I started to receiver the following message:
    ## objc[4193]: Class JavaLaunchHelper is implemented in both /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/bin/java and /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/jre/lib/libinstrument.dylib. One of the two will be used. Which one is undefined.
    ##
    ## A fix was discovered here: http://stackoverflow.com/a/37896401
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
    pathmunge $JAVA_HOME/bin before; export PATH
elif [[ "${OSTYPE//[0-9.]/}" = 'msys' ]]; then
    #--------------------------------------
    # JAVA 11
    #--------------------------------------
    export JAVA_HOME=/c/jdk-11
    pathmunge ${JAVA_HOME}/bin before; export PATH
else
    #--------------------------------------
    # JAVA 11
    #--------------------------------------
    export JAVA_HOME=/usr/lib/jvm/jdk-11.0.4
    pathmunge ${JAVA_HOME}/bin before; export PATH
    export J2SDKDIR=${JAVA_HOME}

    #--------------------------------------
    # JAVA 8
    #--------------------------------------
    #export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_221/
    #pathmunge ${JAVA_HOME}/bin before; export PATH
    #export JRE_HOME=${JAVA_HOME}/jre/
    #export J2SDKDIR=${JAVA_HOME}
    #export J2REDIR=${JAVA_HOME}/jre/
fi

#--------------------------------------
# SBT options
#--------------------------------------
export SBT_OPTS="-Xmx2G -Xss4M -XX:+CMSClassUnloadingEnabled"

if [[ "${OSTYPE//[0-9.]/}" = 'darwin' ]]; then
    # =========================================
    # Settings due to keg installs
    # =========================================
    export LDFLAGS="-L/usr/local/opt/readline/lib"
    export CPPFLAGS="-I/usr/local/opt/readline/include"
    export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

    pathmunge /usr/local/opt/sqlite/bin before; export PATH
    export LDFLAGS="-L/usr/local/opt/sqlite/lib"
    export CPPFLAGS="-I/usr/local/opt/sqlite/include"
    export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

    pathmunge /usr/local/opt/ruby/bin before; export PATH
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
    export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

    pathmunge /usr/local/opt/icu4c/bin before; export PATH
    export LDFLAGS="-L/usr/local/opt/icu4c/lib"
    export CPPFLAGS="-I/usr/local/opt/icu4c/include"
    export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

    pathmunge /usr/local/opt/gettext/bin before; export PATH
    export LDFLAGS="-L/usr/local/opt/gettext/lib"
    export CPPFLAGS="-I/usr/local/opt/gettext/include"

    pathmunge /usr/local/sbin before; export PATH
    pathmunge /Users/caeadom/.npm-packages/bin before; export PATH

    # Oracle additions
    export ORACLE_HOME=/Users/caeadom/Documents/oracle/instantclient_11_2
    export TNS_ADMIN=$ORACLE_HOME/network/admin
    #export DYLD_LIBRARY_PATH=$ORACLE_HOME
    pathmunge $ORACLE_HOME after; export PATH

    # Python and SciPy stack
    pathmunge /Users/caeadom/Library/Python/3.6/bin after; export PATH

    # The path_helper utility reads the contents of the files in the directories
    # /etc/paths.d and /etc/manpaths.d and appends their contents to the PATH and
    # MANPATH environment variables respectively. The MANPATH environment variable
    #  will not be modified unless it is already set in the environment.
    eval $(/usr/libexec/path_helper -s)

    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi

# http://apple.stackexchange.com/questions/12993/why-doesnt-bashrc-run-automatically#comment13715_13019
#
# ON OS X by default, Terminal starts the shell via /usr/bin/login, which
# makes the shell a login shell. On every platform (not just Mac OS X) bash
# does not use .bashrc for login shells (only /etc/profile and the first of
# .bash_profile, .bash_login, .profile that exists and is readable). This is
# why 'put source ~/.bashrc in your .bash_profile' is standard advice.
# -- Chris Johnsen
if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

[[ "${OSTYPE//[0-9.]/}" = 'darwin' ]] \
    && echo "$( date +%T%z ) End sourcing .bash_profile..." \
    || echo "$( date +%T.%N%z ) End sourcing .bash_profile..."

