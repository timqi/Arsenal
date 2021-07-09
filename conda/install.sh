setup() {
	INSTALL_FILE="$ARSENALTEMPDIR/miniconda.sh"
    if [[ -d "$PLUGIN_DIR/miniconda" ]]; then
        return
    fi

    url=$1
    curl -o $INSTALL_FILE $url
    sh $INSTALL_FILE -b -f -s -p "$PLUGIN_DIR/miniconda"
}

if [[ $(OSTYPE) == "macos" ]]; then
    setup "https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-MacOSX-x86_64.sh"
elif [[ $(OSTYPE) != "win" ]]; then
    setup "https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh"
fi
