THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PASSWORD=adb
USER=androidbuilder
HOME=/home/$USER
INSTALL="install -o $USER -g $USER"

deluser $USER --remove-home 2>/dev/null
rm -rf $HOME
cat <<EOF | adduser $USER --gecos $USER 2>&1
$PASSWORD
$PASSWORD
EOF

