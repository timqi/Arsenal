function nn() {
    if [[ -n $2 ]]; then
        VER="$2"
    else
        VER="12.14.1"
    fi
    NODETMP="$ARSENALDIR/tmp/node"
    NODEROOT="$ARSENALDIR/node/source"
    NODEPATH="$NODEROOT/$VER"

    case $1 in
        list)
            for ver in $NODEROOT/*; do
                echo $ver
            done
            echo "\033[32mCurrent: $(node -v)"
            ;;
        install)
            if [[ -d "$NODEPATH" ]]; then
                echo "v$VER alreay exist."
                return
            fi

            if [[ $(OSTYPE) == "macos" ]]; then
                FILENAME="node-v$VER-darwin-x64.tar.gz"
            else
                FILENAME="node-v$VER-linux-x64.tar.xz"
            fi

            rm -rf $NODETMP && mkdir -p $NODETMP

            URL="https://nodejs.org/dist/v$VER/$FILENAME"
            HTTP_CODE=`curl -o /dev/null -s --head -w "%{http_code}" $URL`
            if [[ $HTTP_CODE -ne "200" ]]; then
                echo "\033[31mDownload Failed. VERSION may wrong. $HTTP_CODE"
                return
            fi

            curl -o "$NODETMP/$FILENAME" $URL
            mkdir -p $NODEPATH
            if [[ $(OSTYPE) == "macos" ]]; then
                tar -zxf "$NODETMP/$FILENAME" --strip-components 1 -C $NODEPATH
            else
                tar -Jxf "$NODETMP/$FILENAME" --strip-components 1 -C $NODEPATH
            fi

            rm -rf $ARSENALDIR/bin/node
            ln -sfFv $NODEPATH/bin $ARSENALDIR/bin/node
            rm -rf "$ARSENALDIR/tmp"
            ;;
        use)
            rm -rf $ARSENALDIR/bin/node
            ln -sfFv $NODEPATH/bin $ARSENALDIR/bin/node
            ;;
        rm)
            rm -rf $NODEPATH
            ;;
        *)
            echo "  nn list"
            echo "  nn use [ver default:12.14.1]"
            echo "  nn install [ver default:12.14.1]"
            echo "  nn rm [ver default:12.14.1]"
            echo ""
            nn list
            ;;
    esac
}
