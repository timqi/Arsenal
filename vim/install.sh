VIM_DIR=$HOME/.vim
[[ -d $VIM_DIR ]] && rm -rf $VIM_DIR
ln -sfFv $PLUGIN_DIR $VIM_DIR

ln -sfFv $PLUGIN_DIR/vimrc $HOME/.vimrc

[[ ! -f $ARSENALDIR/vim/autoload/plug.vim ]] && \
	curl -fLo $ARSENALDIR/vim/autoload/plug.vim --create-dirs \
		  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
