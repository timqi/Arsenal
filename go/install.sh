#[[ ! -n $https_proxy ]] \
#    && echo "No proxy dectected, skip install go." \
#    && return

VER="1.15"

if [[ `go version` == *$VER* ]]; then
   echo "go$VER already installed"
   return
fi

GOTMP=$ARSENALDIR/tmp/go && mkdir -p $GOTMP
if [[ `uname -a` == *Darwin* ]]; then
    FILENAME="go$VER.darwin-amd64.tar.gz"
else
    FILENAME="go$VER.linux-amd64.tar.gz"
fi
URL="https://dl.google.com/go/$FILENAME"
curl -o "$GOTMP/$FILENAME" $URL

GODIR=$ARSENALDIR/go/source
[[ ! -d $GODIR ]] && mkdir -p $GODIR
rm -rf $GODIR/*
tar -xzf "$GOTMP/$FILENAME" --strip-components 1 -C $GODIR

ln -sfFv $GODIR/bin/go $ARSENAL_SELF_BIN_DIR
ln -sfFv $GODIR/bin/gofmt $ARSENAL_SELF_BIN_DIR
