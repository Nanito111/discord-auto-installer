declare install_directory="/opt/"
declare temporal_directory="/tmp/"
declare bin_directory="/usr/local/bin/"
declare application_shorcut_directory="/usr/share/applications/"
declare icon_directory="/usr/share/icons/hicolor/256x256/apps/"
declare discord_download="discord.tar.gz"

# kill any currently running Discord
if pgrep Discord ; then
  pkill Discord
  sleep 1
  pkill -9 Discord
fi

# make sure the script is running with sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "Please, run this script with sudo.";
  exit 1;
fi

# remove previous download if exist
if [ -f "${temporal_directory}${discord_download}" ]; then
    echo "Removing previous Discord download";
    rm "${temporal_directory}${discord_download}";
fi

# download discord.tar.gz and save it in temporal directory
curl -L "https://discord.com/api/download?platform=linux&format=tar.gz" -o "${temporal_directory}${discord_download}";

# decompress discord.tar.gz into installation directory
echo "Extracting ${discord_download} into ${install_directory}";
tar -xzf "${temporal_directory}${discord_download}" -C $install_directory;

# remove symbolic link from bin directory if exist
if [ -f "${bin_directory}discord" ]; then
    echo "Removing old symbolic link in ${bin_directory}";
    rm "${bin_directory}discord";
fi

# create symbolic link in bin directory
echo "Creating symbolic link from ${install_directory}Discord/Discord to ${bin_directory}Discord";
ln -sf "${install_directory}Discord/Discord" "${bin_directory}Discord";

# remove desktop file if exist
if [ -f "${application_shorcut_directory}discord.desktop" ]; then
    echo "Removing old discord.desktop from ${application_shorcut_directory}";
    rm "${application_shorcut_directory}discord.desktop";
fi

# copy discord shortcut into application_shorcut_directory
echo "Copying discord.desktop to ${application_shorcut_directory}";
cp -r "${install_directory}Discord/discord.desktop" $application_shorcut_directory;

# Re-assign variables Exec & Path
echo "Re-assign discord.desktop variables Exec & Path";
sed -i "s|Exec=.*|Exec=${install_directory}Discord/Discord|" "${application_shorcut_directory}discord.desktop";
sed -i "s|Path=.*|Path=${bin_directory}|" "${application_shorcut_directory}discord.desktop";

# remove icon image if exist
if [ -f "${icon_directory}discord.png" ]; then
    echo "Removing old icon from ${icon_directory}";
    rm "${icon_directory}discord.png";
fi

# install icon reference
install -D "${install_directory}/Discord/discord.png" "${icon_directory}discord.png";

# execute post installation script from discord download
echo "Executing Discord post installation script";
bash "${install_directory}/Discord/postinst.sh";
