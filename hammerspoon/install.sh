if [[ $(OSTYPE) == "macos" ]]; then
    HAMMERSPOON_DIR=$HOME/.hammerspoon
    [[ -d $HAMMERSPOON_DIR ]] && rm -rf $HAMMERSPOON_DIR
    ln -sfFv $PLUGIN_DIR $HAMMERSPOON_DIR
fi
