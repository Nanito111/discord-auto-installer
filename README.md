# Discord Installation Script

This script automates the installation process of Discord on a Linux system. It ensures a clean installation by removing any existing Discord instances, symbolic links, and desktop shortcuts before proceeding. The script also handles the download, extraction, and configuration of Discord.

## Usage

**Note:** Run this script with elevated privileges.

```bash
sudo bash install_discord.sh
```

## Installation Directories

**Note:** The installation directories can be customized based on personal preferences. If you wish to change the default paths, you can modify the corresponding variables at the beginning of the script.

- **Installation Directory:** `/opt/`
- **Temporary Directory:** `/tmp/`
- **Binary Directory:** `/usr/local/bin/`
- **Application Shortcut Directory:** `/usr/share/applications/`
- **Icon Directory:** `/usr/share/icons/hicolor/256x256/apps/`

To customize the installation directories, update the following variables at the beginning of the script:

```bash
declare install_directory="/opt/"
declare temporal_directory="/tmp/"
declare bin_directory="/usr/local/bin/"
declare application_shorcut_directory="/usr/share/applications/"
declare icon_directory="/usr/share/icons/hicolor/256x256/apps/"
```

Adjust these paths according to your preferences and system requirements before running the script.

## Steps Performed by the Script

1. **Kill Running Discord Instances:** The script terminates any running Discord processes to ensure a clean installation.

2. **Check for Root Privileges:** Verifies that the script is being run with sudo.

3. **Remove Previous Downloads:** Deletes any previous Discord tar.gz download in the temporary directory.

4. **Download Discord:** Fetches the latest Discord tar.gz version from the official website and saves it in the temporary directory.

5. **Extract Discord:** Decompresses the downloaded tar.gz file into the installation directory.

6. **Remove Old Symbolic Link:** Deletes the old symbolic link in the binary directory if it exists.

7. **Create Symbolic Link:** Creates a symbolic link from the Discord binary to the binary directory.

8. **Remove Old Desktop File:** Deletes the old Discord desktop shortcut if it exists.

9. **Copy Desktop File:** Copies the Discord desktop shortcut to the system's application shortcut directory.

10. **Re-assign Variables in Desktop File:** Modifies the Exec and Path variables in the desktop file to reflect the installation paths.

11. **Remove Old Icon:** Deletes the old Discord icon if it exists.

12. **Install Icon:** Installs the Discord icon in the system's icon directory.

13. **Execute Post Installation Script:** Runs the post-installation script provided by Discord.

## Note

- Ensure that the script is run with sudo to avoid permission issues.
- The script may require an internet connection to download the latest Discord version.
- It is recommended to review the script and update the variables if necessary.

Feel free to contribute to and modify this script based on your system's specific requirements.
