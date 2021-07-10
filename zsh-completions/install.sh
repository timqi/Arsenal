if [[ -d $PLUGIN_SOURCE_DIR ]] ; then
    cd $PLUGIN_SOURCE_DIR
    git pull --depth 1 --rebase --allow-unrelated-histories
else
    SOURCE_URL="git://github.com/zsh-users/zsh-completions.git"
    git clone --depth=1 $SOURCE_URL $PLUGIN_SOURCE_DIR
fi

fpath=($PLUGIN_SOURCE_DIR/src $fpath)
rm -f ~/.zcompdump; compinit
