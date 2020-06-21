if [[ -d $PLUGIN_SOURCE_DIR ]] ; then
    cd $PLUGIN_SOURCE_DIR
    git pull --depth 1 --rebase --allow-unrelated-histories
else
    SOURCE_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
    git clone --depth=1 $SOURCE_URL $PLUGIN_SOURCE_DIR
fi
