. $PLUGIN_DIR/init.zsh
nn install

NPMRCPATH=$HOME/.npmrc
ln -sfFv "$PLUGIN_DIR/npmrc" $NPMRCPATH
