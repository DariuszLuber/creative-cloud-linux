#!/usr/bin/env bash
# Date : (02-15-2018)
# Distribution used to test : Ubuntu 17.10 x64
# Author : Corbin Davenport
# Licence : GPLv3
# PlayOnLinux: 4.2.12

# Based on RoninDusette's script
# from https://www.playonlinux.com/en/app-2316-Adobe_Photoshop_CS6.html

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="CreativeCloudDev"
WINEVERSION="3.20"
TITLE="Adobe Creative Cloud"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="Corbin Davenport"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3251

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Explain Linux dependencies
POL_SetupWindow_message "$(eval_gettext 'Note: Please make sure that the winbind package is installed on your computer. It is required for Adobe Creative Cloud to connect to the internet, and it cannot be automatically installed by PlayOnLinux.\n\nThis is the command for Ubuntu:\nsudo apt-get install winbind\n\nWhen you have installed it, click Next.')" "$TITLE"

# Create prefix and temporary download folder
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate "CreativeCloud"
Set_OS "win7"

# Install dependencies
cd "$POL_System_TmpDir"
# Use winetricks, since the POL_corefonts version does not work with the installer
POL_Download_Resource  "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
POL_SetupWindow_wait "Please wait while winetricks is installed... (this might take a few minutes)" "$TITLE"
chmod +x winetricks
./winetricks atmlib corefonts fontsmooth=rgb gdiplus vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 atmlib msxml3 msxml6 gdiplus wininet winhttp ie8

# Get the installer
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
	POL_SetupWindow_browse "Please select the Adobe Creative Cloud offline installer ZIP file."
	cp "$APP_ANSWER" "$POL_System_TmpDir"
	cd "$POL_System_TmpDir"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
	cd "$POL_System_TmpDir"
	POL_Download "http://ccmdl.adobe.com/AdobeProducts/KCCC/1/win32/ACCCx4_6_0_391.zip"
fi
POL_SetupWindow_wait "Please wait while the installer is extracted..." "$TITLE"
unzip *.zip
INSTALLER="$POL_System_TmpDir/Set-up.exe"
  
# Run the installer
Set_OS "win7"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Shortcut "Creative Cloud.exe" "Adobe Creative Cloud"
POL_System_TmpDelete

# All done
POL_SetupWindow_message "$(eval_gettext 'The installation is now complete, you can now use the Adobe Creative Cloud manager to download the applications you need.\n\nNOTE: The Creative Cloud manager takes a while to log in, and you may see an error meessage. That is completely normal - don't close the login window!\n\nAfter you download an app, you can add a PlayOnLinux shortcut for it by clicking ADOBE CREATIVE CLOUD in the app list, clicking CONFIGURE, and clicking MAKE A NEW SHORTCUT FROM THIS VIRTUAL DRIVE. Then look for the app, like Photoshop.exe, and add it.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
