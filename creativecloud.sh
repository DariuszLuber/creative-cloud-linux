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
WINEVERSION="3.11"
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

# Create prefix and temporary download folder
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate "CreativeCloud"
Set_OS "win7"

# Install dependencies
POL_SetupWindow_wait "Please wait while msxml3 is installed..." "$TITLE"
POL_Call POL_Install_msxml3
POL_Call POL_Install_gdiplus
cd "$POL_System_TmpDir"
# Use winetricks, since the POL_corefonts version does not work with the installer
POL_Download_Resource "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
POL_SetupWindow_wait "Please wait while winetricks is installed. This might take a few minutes." "$TITLE"
chmod +x winetricks
./winetricks atmlib corefonts fontsmooth=rgb

# Download Gecko for 64-bit Wine
cd "$POL_System_TmpDir"
POL_Download "http://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi"
POL_SetupWindow_wait "Please wait while Gecko is installed."
POL_SetupWindow_message "$(eval_gettext 'hold up')" "$TITLE"
POL_AutoWine "$POL_System_TmpDir/wine_gecko-2.47-x86_64.msi"

# Get the installer
cd "$POL_System_TmpDir"
POL_Download "http://ccmdl.adobe.com/AdobeProducts/KCCC/1/win32/ACCCx4_5_0_331.zip"
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
POL_SetupWindow_message "$(eval_gettext 'The installation is now complete, you can now use the Adobe Creative Cloud manager to download the applications you need.\n\nNOTE: The Creative Cloud manager takes a while to log in. That is completely normal.\n\nAfter you download an app, you can add a PlayOnLinux shortcut for it by clicking ADOBE CREATIVE CLOUD in the app list, clicking CONFIGURE, and clicking MAKE A NEW SHORTCUT FROM THIS VIRTUAL DRIVE. Then look for the app, like Photoshop.exe, and add it.')" "$TITLE"
 
POL_SetupWindow_Close
exit 0
