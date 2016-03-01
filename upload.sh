#!/bin/bash
# A script for easily uploading files to a web folder.
# Usage: upload <file to upload> [name in url]
# The file will be uploaded, given [name in url] on the web server, and the
# URL to the file will be printed and put on the clipboard.

readonly SSH_USER=taylordeploy
readonly SSH_HOST=defuse.ca
readonly SSH_PATH="/var/www/defuse.ca-extras/upload/tmp_w"
readonly HTTP_URL="https://defuse.ca/upload/tmp_w"

if [ $# -eq 2 ]; then
    file=$(readlink -f "$1")
    scp "$file" "$SSH_USER@$SSH_HOST:$SSH_PATH/$2"
    strip=$(echo -n "$2" | tr -d " :()\\\\")
    url="$HTTP_URL/$2"
    echo "$url" | xclip -sel clipboard
    echo "$url"
elif [ $# -eq 1 ]; then 
    file=$(readlink -f "$1")
    BN=$(basename "$1")
    BN=$(echo -n "$BN" | tr -d " :()\\\\")
    scp "$file" "$SSH_USER@$SSH_HOST:$SSH_PATH/$BN"
    url="$HTTP_URL/$BN"
    echo "$url" | xclip -sel clipboard
    echo "$url"
else
    echo "Usage: <file to upload> [name in url]"
fi
