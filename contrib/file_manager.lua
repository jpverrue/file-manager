--[[

  file_manager.lua - launch file manager in photo directory with a shortcut

  AUTHOR
  Jean-Pierre Verrue <contact@jpverrue.fr>
  Copyright (C) Jean-Pierre Verrue

  LICENCE
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]
--[[
  
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

]]

local dt = require "darktable"
local du = require "lib/dtutils"

-- module name
local MODULE_NAME = "file_manager"
du.check_min_api_version("7.0.0", MODULE_NAME)

-- return data structure for script_manager

local script_data = {}

script_data.destroy = nil -- function to destory the script
script_data.destroy_method = nil -- set to hide for libs since we can't destroy them commpletely yet, otherwise leave as nil
script_data.restart = nil -- how to restart the (lib) script after it's been hidden - i.e. make it visible again

-- OS compatibility
local PS = dt.configuration.running_os == "windows" and  "\\"  or  "/"

-- translation
local gettext = dt.gettext
gettext.bindtextdomain(MODULE_NAME, dt.configuration.config_dir..PS.."lua"..PS.."locale"..PS)
local function _(msgid)
  return gettext.dgettext(MODULE_NAME, msgid)
end 

dt.preferences.register("file_manager", "file_manager_options",
  "string", _("options"), (_"file manager options"), "")

dt.preferences.register("file_manager", "file_manager_path",
  "string", _("file manager"), _("file manager full path"), "")

local function file_manager_shortcut(event, shortcut)
  local images = dt.gui.action_images
  local image_path = string.gsub(tostring(images[1].path), '"', '\\"')
  local file_manager_path = dt.preferences.read("file_manager", "file_manager_path", "string")
  local file_manager_options = dt.preferences.read("file_manager", "file_manager_options", "string")
  local command = file_manager_path.." "..file_manager_options..' "'..image_path..'"'
  dt.print_log("command="..command)
  dt.control.execute(command)

end

dt.register_event("file_manager", "shortcut", file_manager_shortcut,
_("launch file manager"))

-- end of script --------------------------------------------------------------

-- vim: shiftwidth=2 expandtab tabstop=2 cindent syntax=lua
-- kate: hl Lua;
