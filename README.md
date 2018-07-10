# Creative Cloud for PlayOnLinux (DEVELOPMENT VERSION)

This is the development version of the Creative Cloud installer for PlayOnLinux. It uses the latest version of Wine and a 64-bit pre-fix. However, it is not functional right now - the installer hangs at the log-in screen, I assume some issue with rendering HTML content. If you know how to fix it, please submit a pull request.

## How to use this script

1. Download PlayOnLinux from your distribution's package manager (e.g. Ubuntu Software Center) or from [the PlayOnLinux website](https://www.playonlinux.com/en/download.html)
2. Save the [install script](https://raw.githubusercontent.com/corbindavenport/creative-cloud-linux/master/creativecloud.sh) to your computer
3. Open PlayOnLinux, go to Tools > Run a local script
4. Select the install script you just downloaded

After the setup process is finished, you can open `Adobe Creative Cloud` from PlayOnLinux to download and install the apps you need. After you download an app, you can add a PlayOnLinux shortcut for it by clicking Adobe Application Manager in the app list, clicking `Configure`, and clicking `Make a new shortcut from this virtual drive`. Then look for the app you need, like Photoshop.exe, and add it.

**Tip:** Tooltips in Photoshop might not disappear automatically. You can turn off tooltips completely by going to `Edit > Preferences > Tools` and un-checking the `Show tooltips` box.

If the installer crashes, see the [Troubleshooting page](https://github.com/corbindavenport/creative-cloud-linux/wiki/Troubleshooting). If you still have issues, try [the classic script](https://github.com/corbindavenport/creative-cloud-linux/tree/classic).

---------------------------------------

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
