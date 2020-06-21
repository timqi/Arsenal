CURR_VER="0.0.0"
if command -v rg &>/dev/null; then
	CURR_VER=`rg -V | head -n 1 | cut -d " " -f2`
fi

TAG_URL="https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"
NEW_VER=`curl -s ${TAG_URL} --connect-timeout 10| grep 'tag_name' | cut -d\" -f4`

if [[ $CURR_VER == $NEW_VER ]]; then
	echo "ripgrep is already the newest."
else
	echo "ripgrep will install: v$NEW_VER ..."
	ARCH="unknown-linux-musl"
	if [[ `uname -a` == *Darwin* ]]; then
		ARCH="apple-darwin"
	fi
	DOWNLOAD_URL="https://github.com/BurntSushi/ripgrep/releases/download/$NEW_VER/ripgrep-$NEW_VER-x86_64-$ARCH.tar.gz"

	TMP_DIR="$ARSENALTEMPDIR/ripgrep"
	mkdir -p $TMP_DIR
	TAR_FILE="$TMP_DIR/ripgrep.tar.gz"

	curl -L -H "Cache-Control: no-cache" -o $TAR_FILE $DOWNLOAD_URL
	tar -zxvf $TAR_FILE -C $TMP_DIR
	cp $TMP_DIR/*/rg $ARSENAL_SELF_BIN_DIR

	logv "ripgrep $NEW_VER installed."
fi
