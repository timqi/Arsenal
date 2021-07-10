function is_command_exists() {
	if command -v $1 &> /dev/null; then
		return 1;
	else
		return 0;
	fi
}

export all_proxy=""
export http_proxy=""
export https_proxy=""

function proxy(){
    case $1 in
        set)
            [[ ! -n $2 ]] && all_proxy="socks5://127.0.0.1:7890"
            http_proxy=$2
            [[ ! -n $2 ]] && http_proxy="http://127.0.0.1:7890"
            https_proxy=$2
            [[ ! -n $2 ]] && https_proxy="http://127.0.0.1:7890"
			proxy show;
            ;;
        unset)
            all_proxy=""
            http_proxy=""
            https_proxy=""
			proxy show;
            ;;
        show)
            echo "all_proxy=$all_proxy"
            echo "http_proxy=$http_proxy"
            echo "https_proxy=$https_proxy"
            ;;
        *)
            proxy show
            echo ""
            echo "  proxy set (set proxy using by clash)"
            echo "  proxy unset"
            echo "  proxy show"
            ;;
    esac
}

function OSTYPE() {
    UNAME_FULL="`uname -a`"
    case $UNAME_FULL in
        *[dD]arwin* ) echo "macos";;
        *[uU]buntu* ) echo "ubuntu";;
		*Microsoft* ) echo "win";;
        *) echo "unknown";;
    esac
}

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM="xterm-256color"

alias ls='ls --group-directories-first --color=auto'
alias l='ls -lhA'
alias grep='grep --color=auto'
alias g='git'
