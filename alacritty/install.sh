if [[ $(OSTYPE) == "macos" ]] || [[ $(OSTYPE) == "win" ]]; then
    ln -sfFv $PLUGIN_DIR/alacritty.yml $HOME/.alacritty.yml
fi
