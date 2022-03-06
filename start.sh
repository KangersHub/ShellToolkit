if [[ -n $RCLONE_CONFIG_BASE64 ]]; then
	echo "Rclone config detected"
    mkdir -p /usr/src/app/.config/rclone
	echo "$(echo $RCLONE_CONFIG_BASE64|base64 -d)" >> /usr/src/app/.config/rclone/rclone.conf && rclone --config=“.config/rclone/rclone.conf”
fi

if [[ -n $BOT_TOKEN && -n $OWNER_ID ]]; then
	echo "Bot token and owner ID detected"
	python3 config.py
fi

if [[ -n $CREDENTIALS_LINK ]]; then
	echo "credentials.json detected"
    aria2c $CREDENTIALS_LINK && drivedl set /usr/src/app/credentials.json
fi

if [[ -n $ACCOUNTS_FOLDER_LINK ]]; then
	echo "accounts.zip detected"
    aria2c $ACCOUNTS_FOLDER_LINK && unzip accounts.zip -d accounts && rm *.zip
fi

echo "NOW SETTING UP ARIA2 and QBT engine"

tracker_list=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$1' | tr '\n' ',' | cat`
qbit_trackers_list=$(curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$0' | tr '\n' ',')
echo -e "\nmax-concurrent-downloads=7\nbt-tracker=$tracker_list" >> /usr/src/app/aria.conf
echo -e "\nBittorrent\add_trackers=$=$qbit_trackers_list" >> /usr/src/app/qBittorrent.conf
aria2c --conf-path="aria2.conf" -D
mkdir .config/qBittorrent
cp qBittorrent.conf .config/qBittorrent/qBittorrent.conf

echo "SETUP COMPLETED"

node server
