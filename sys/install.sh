ZSHRC="$HOME/.zshrc"
ln -sfFv "$PLUGIN_DIR/zshrc" $ZSHRC

TMUX_CONFIG=$HOME/.tmux.conf
ln -sfFv $PLUGIN_DIR/tmux.conf $TMUX_CONFIG

GIT_CONFIG=$HOME/.gitconfig
ln -sfFv "$PLUGIN_DIR/gitconfig" $GIT_CONFIG

ALACRITTY_CONFIG=$HOME/.alacritty.yml
ln -sfFv "$PLUGIN_DIR/alacritty.yml" $ALACRITTY_CONFIG
