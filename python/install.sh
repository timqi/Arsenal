PIP_LINK="$HOME/.pip"
[[ -d $PIP_LINK ]] && rm -rf $PIP_LINK
ln -sfFv $PLUGIN_DIR/pip $PIP_LINK

PYENV_DIR=$PLUGIN_DIR/source
VIRTUALENV_DIR=$PYENV_DIR/plugins/pyenv-virtualenv

if [[ -d $PYENV_DIR ]] ; then
    cd $PYENV_DIR
    git pull --depth 1 --rebase --allow-unrelated-histories

    cd $VIRTUALENV_DIR
    git pull --depth 1 --rebase --allow-unrelated-histories
else
    SOURCE_URL="https://github.com/pyenv/pyenv.git"
    git clone --depth=1 $SOURCE_URL $PYENV_DIR

    SOURCE_URL="https://github.com/pyenv/pyenv-virtualenv.git"
    git clone --depth=1 $SOURCE_URL $VIRTUALENV_DIR
fi

ln -sfFv $PYENV_DIR ~/.pyenv
