# Basado (ok, copiado) en el trabajo de bbatsov (prelude)

install_dotfiles () {
    printf "$BBLUE Cloning repository from github...\n$RESET"
    if [ x$DOTFILES_VERBOSE != x ]
    then
        /usr/bin/env git clone $DOTFILES_URL "$DOTFILES_INSTALL_DIR"
    else
        /usr/bin/env git clone $DOTFILES_URL "$DOTFILES_INSTALL_DIR" > /dev/null
    fi
    if ! [ $? -eq 0 ]
    then
        printf "$RED Fatal error!!! Aborting the mission...\n\n"
        exit 1
    fi
}

make_symbolic_links () {
    printf "$BBLUE Creating required symbolic links.\n$RESET"

    for ARCHIVO in .bashrc .zshrc .screenrc .gitconfig .gitignore .psqlrc .sqliterc .tmux.conf
    do
        if [ -f $HOME/$ARCHIVO ] && [ ! -h $HOME/$ARCHIVO ]
        then
            printf "$BYELLOW $ARCHIVO already exists, let's do a backup\n"
            mv $HOME/$ARCHIVO $HOME/$ARCHIVO.old
	fi
        ln -s $DOTFILES_INSTALL_DIR/${ARCHIVO#"."} $ARCHIVO
    done
}

colors_ () {
    case "$SHELL" in
    *zsh)
        autoload colors && colors
        eval RESET='$reset_color'
        for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE
        do
            eval $COLOR='$fg_no_bold[${(L)COLOR}]'
            eval B$COLOR='$fg_bold[${(L)COLOR}]'
        done
        ;;
    *)
        RESET='\e[0m' # Reset
        RED='\e[0;31m' # Red
        GREEN='\e[0;32m' # Green
        YELLOW='\e[0;33m' # Yellow
        BLUE='\e[0;34m' # Blue
        PURPLE='\e[0;35m' # Magenta
        CYAN='\e[0;36m' # Cyan
        WHITE='\e[0;37m' # White
        BRED='\e[1;31m' # Bold Red
        BGREEN='\e[1;32m' # Bold Green
        BYELLOW='\e[1;33m' # Bold Yellow
        BBLUE='\e[1;34m' # Bold Blue
        BPURPLE='\e[1;35m' # Bold Magenta
        BCYAN='\e[1;36m' # Bold Cyan
        BWHITE='\e[1;37m' # Bold White
        ;;
    esac
}

VERBOSE_COLOR=$BBLUE
DORFILES_VERBOSE='true'

[ -z "$DOTFILES_URL" ] && DOTFILES_URL="https://github.com/dssg/dotfiles.git"
[ -z "$DOTFILES_INSTALL_DIR" ] && DOTFILES_INSTALL_DIR="$HOME/dotfiles"

if [ x$DOTFILES_VERBOSE != x ]
then
    printf "$VERBOSE_COLOR"
    printf "DOTFILES_VERBOSE = $DOTFILES_VERBOSE\n"
    printf "INSTALL_DIR = $DOTFILES_INSTALL_DIR\n"
    printf "SOURCE_URL = $DOTFILES_URL\n"
    printf "$RESET"
fi

# Si ya están instalados los dotfiles
if [ -d "$DOTFILES_INSTALL_DIR/zshrc" ]
then
    printf "\n\n$BRED"
    printf "Ya tienes instalados los dotfiles.$RESET\nYou must delete $DOTFILES_INSTALL_DIR if you want to install again this repository.\n"
    printf "If you just want to update your local copy, execute 'git pull origin master' from inside $DOTFILES_INSTALL_DIR\n\n"
    exit 1;
fi

### Verificar dependencias
printf "$CYAN Is git installed...? $RESET"
if hash git 2>&-
then
    printf "$GREEN found!.$RESET\n"
else
    printf "$RED not found! Aborting installation!$RESET\n"
exit 1
fi;


# Instalando los dotfiles
install_dotfiles
make_symbolic_links

printf "\n"
printf "$BBLUE\n"
printf "$BBLUE     _       _      __ _ _            \n"
printf "$BBLUE    | |     | |    / _(_) |           \n"
printf "$BBLUE  __| | ___ | |_  | |_ _| | ___  ___  \n"
printf "$BBLUE / _  |/ _ \| __| |  _| | |/ _ \/ __| \n"
printf "$BBLUE| (_| | (_) | |_  | | | | |  __/\__ \ \n"
printf "$BBLUE \____|\___/ \__| |_| |_|_|\___||___/ \n\n"
printf "$GREEN ... is installed and ready to improve your CLI experience $USER! ;)$RESET\n"
