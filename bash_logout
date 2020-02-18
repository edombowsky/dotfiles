# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# When leaving the console clear the screen to increase privacy. Also clear the
# scroll-back buffer by switching to tty63 and back.
case "$(tty)" in
    /dev/tty[0-9])
        t=$(v=`tty` ; echo ${v##*ty})
        clear
        chvt 63; chvt "$t"
        ;;

    /dev/tty[0-9][0-9])
        t=$(v=`tty` ; echo ${v##*ty})
        clear
        chvt 63; chvt "$t"
        ;;

    *)
        ;;
esac
