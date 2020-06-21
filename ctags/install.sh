if [[ `uname -a` == *Darwin* ]]; then
	brew tap universal-ctags/universal-ctags
	brew install --HEAD universal-ctags/universal-ctags/universal-ctags
else 
	TMP_DIR="$ARSENALTEMPDIR/ctags"
	git clone https://github.com/universal-ctags/ctags.git $TMP_DIR --depth=1
	cd $TMP_DIR
	logv "configure ctags ..."
	./autogen.sh &>/dev/null
	./configure --prefix=$TMP_DIR &>/dev/null
	logv "make ctags ..."
	make &>/dev/null
	make install
	cp $TMP_DIR/bin/* $ARSENAL_SELF_BIN_DIR
	cd $ARSENALDIR
fi
