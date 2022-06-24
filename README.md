Lua script for darktable

file manager - launch file manager in photo directory with a shortcut

INSTALLATION
* copy this file in $CONFIGDIR/lua/ where CONFIGDIR is your darktable configuration directory
* add the following line in the file $CONFIGDIR/luarc
  require "fnav"

USAGE
* configure this script :
	* set a shortcut in preferences->shortcut->lua
	* set file manager path in preferences->lua options
	* set file manager options in preferences->lua options
* select a photo
* type your shortcut
* after use dont forget to close file manager window !
