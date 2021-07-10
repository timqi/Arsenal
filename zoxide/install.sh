CURR_VER="0.0.0"
if command -v rg &>/dev/null; then
	CURR_VER=`zoxide -V | head -n 1 | cut -d " " -f2`
fi

TAG_URL="https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest"
NEW_VER=`curl -s ${TAG_URL} --connect-timeout 10| grep 'tag_name' | cut -d\" -f4`

if [[ $CURR_VER == $NEW_VER ]]; then
	echo "zoxide is already the newest."
else
	echo "zoxide will install: $NEW_VER ..."
	ARCH="unknown-linux-musl"
	if [[ `uname -a` == *Darwin* ]]; then
		ARCH="apple-darwin"
	fi
	DOWNLOAD_URL="https://github.com/ajeetdsouza/zoxide/releases/download/$NEW_VER/zoxide-x86_64-$ARCH.tar.gz"

	TMP_DIR="$ARSENALTEMPDIR/zoxide"
	mkdir -p $TMP_DIR
	TAR_FILE="$TMP_DIR/zoxide.tar.gz"

	curl -L -H "Cache-Control: no-cache" -o $TAR_FILE $DOWNLOAD_URL
	tar -zxvf $TAR_FILE -C $TMP_DIR
	cp $TMP_DIR/*/zoxide $ARSENAL_SELF_BIN_DIR

	logv "zoxide $NEW_VER installed."
fi
