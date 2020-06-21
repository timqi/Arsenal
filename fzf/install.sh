if [[ -e $PLUGIN_SOURCE_DIR ]] ; then
    cd $PLUGIN_SOURCE_DIR
    git pull --depth 1 --rebase --allow-unrelated-histories
else
    SOURCE_URL="https://github.com/junegunn/fzf.git"
    git clone --depth=1 $SOURCE_URL $PLUGIN_SOURCE_DIR
fi

FZF_DIR=$HOME/.fzf
[[ -d $FZF_DIR ]] && rm -rf $FZF_DIR
ln -sfFv $PLUGIN_SOURCE_DIR $FZF_DIR
$HOME/.fzf/install --bin

ln -sfFv $PLUGIN_SOURCE_DIR/bin/fzf $ARSENAL_SELF_BIN_DIR
ln -sfFv $PLUGIN_SOURCE_DIR/bin/fzf-tmux $ARSENAL_SELF_BIN_DIR
