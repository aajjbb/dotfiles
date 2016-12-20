--[[
   Starbreaker Awesome WM config 0.1
   github.com/demifiend

   Based on...

   Multicolor Awesome WM config 2.0
   github.com/copycat-killer

   Modified by aajjbb:
   github.com/aajjbb
--]]

-- {{{ Required libraries

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")

-- External
--local drop      = require("scratchdrop")
local lain      = require("lain")
local rev       = require("awesome-revelation")
local xrandr    = require("xrandr")

-- Support to utf8 string sub, install with luautf8 with luarocks
local utf8      = require 'lua-utf8'

local lain_icons_dir = require("lain.helpers").icons_dir

require("awful.autofocus")
awful.rules     = require("awful.rules")

-- }}}

-- {{{ Error handling
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, an error happened!",
                                              text = err })
                             in_error = false
   end)
end
-- }}}

-- {{{ Autostart applications

local spawn_once = function(command, class, tag)
   -- create move callback
   local callback
   callback = function(c)
      if c.name == class then
         awful.client.movetotag(tag, c)
         client.disconnect_signal("manage", callback)
      end
   end
   client.connect_signal("manage", callback)
   -- now check if not already running!
   local findme = command
   local firstspace = findme:find(" ")
   if firstspace then
      findme = findme:sub(0, firstspace-1)
   end
   -- finally run it
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. command .. ")")
end

-- }}}

-- {{{ Variable definitions

-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/starbreaker/theme.lua")
--beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/awesome-themes-3.5/dust/heme.lua")

-- awesome-revelation init
rev.init()


--


-- common
local markup     = lain.util.markup
local modkey     = "Mod4"
local altkey     = "Mod1"
local terminal   = "urxvtc" or "xterm"

-- user defined
local browser = "xfirefox"
local browser2 = "xgoogle-chrome-stable"
local gui_editor = "emacs"
local graphics = "pinta"
local mail = "thunderbird"
local word_processor = "libreoffice --writer"
local music = "cmus"
local files = "caja --no-desktop"
local screenshot = "scrot -q 100 '%Y-%m-%d-%k-%M-%S_$wx$h.png' -e 'mv $f ~/Pictures/Screenshot/'"

local layouts = {
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
   awful.layout.suit.tile.bottom,
   awful.layout.suit.floating,
   lain.layout.uselesstile,
   lain.layout.uselessfair,
}
-- }}}

-- {{{ Tags
local tags = {
   names = {
      "web",
      "emacs",
      "term",
      "chat",
      "music",
      "docs",
      "other",
   },
   layout = {
      layouts[1],
      layouts[1],
      layouts[1],
      layouts[1],
      layouts[1],
      layouts[1],
      layouts[1]
   }
}

for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Wallpaper

local wp_index = 1
local wp_timeout  = 40
local wp_path = os.getenv("HOME") .. "/.config/awesome/themes/starbreaker/"
local wp_files = {
   "1.jpg",
   "2.jpg",
   "3.jpg",
   "4.jpg"
}

for s = 1, screen.count() do
   -- Random Wallpaper
   -- configuration - edit to your liking

   -- setup the timer
   wp_timer = timer { timeout = wp_timeout }
   wp_timer:connect_signal("timeout", function()
                              -- set wallpaper to current index
                              gears.wallpaper.maximized(wp_path .. wp_files[wp_index] , s, true)

                              -- stop the timer (we don't need multiple instances running at the same time)
                              wp_timer:stop()

                              -- get next random index
                              wp_index = math.random( 1, #wp_files)

                              --restart the timer
                              wp_timer.timeout = wp_timeout
                              wp_timer:start()
   end)
end
-- initial start when rc.lua is first run
-- gears.wallpaper.maximized(beautiful.wallpaper, s, true)
wp_timer:start()



-- }}}

-- {{{ Freedesktop Menu
local freedesktopmenu = require("menugen").build_menu()
local awesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "config", gui_editor .. " ~/.config/awesome/rc.lua" },
   { ".Xresources", gui_editor .. " ~/.Xresources" },
   { ".xprofile", gui_editor .. " ~/.xprofile" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

local mymainmenu = awful.menu.new({ items = {
                                       { "music", music },
                                       { "terminal", terminal },
                                       { "files", files },
                                       { "text editor", gui_editor },
                                       { "word processor", word_processor },
                                       { "web browser", browser },
                                       { "lightweight browser", browser2 },
                                       { "mail", mail },
                                       { "im", im },
                                       { "apps", freedesktopmenu },
                                       { "awesome", awesomemenu }
},
                                    theme = { height = 16, width = 150 }})
-- }}}

-- Widgets

-- Menu buttom

local menu_buttom = wibox.widget.imagebox(beautiful.submenu_icon)

menu_buttom:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () mymainmenu:toggle() end)))

-- Redshift

local redshift = lain.widgets.contrib.redshift
local redshift_widget = wibox.widget.imagebox(rs_on)

redshift:attach(
   redshift_widget,
   function ()
      local rs_on  = lain_icons_dir .. "/redshift/redshift_on.png"
      local rs_off = lain_icons_dir .. "/redshift/redshift_off.png"

      if redshift:is_active() then
         redshift_widget:set_image(rs_on)
      else
         redshift_widget:set_image(rs_off)
      end
   end
)

redshift_widget:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () redshift:toggle() end)))

-- Textclock
local clockicon   = wibox.widget.imagebox(beautiful.widget_clock)
local mytextclock = awful.widget.textclock(" " .. markup("#7788af", "%d %B %Y ") .. markup("#eee8d5", ">") .. markup("#de5e1e", " %I:%M %p "))

-- Calendar
lain.widgets.calendar.attach(mytextclock, {
                                font_size = 10,
                                position = "top_right"
                                -- font = "MesloLGM 9"
})

-- Weather
local weather = lain.widgets.weather({
      city_id = 3453837,
      settings = function()
         if weather_now then
            local units = math.floor(weather_now["main"]["temp"])
            widget:set_markup(" " .. markup("#eca4c4", " " .. string.format("%2d", units) .. "°C "))
         end
      end
})

-- fs
local fsicon = wibox.widget.imagebox(beautiful.widget_fs)
local fswidget = lain.widgets.fs({
      settings  = function()
         local script_response = io.popen('./.config/awesome/lain/scripts/dfs')
         local text = script_response:read('*all')
         fs_notification_preset = {
            title = text,
            height = 220
         }
         widget:set_markup(" " .. markup("#80d9d8", fs_now.used .. "% "))
      end
})

-- CPU
local cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)

local cpuwidget = lain.widgets.cpu({
      settings = function()
         widget:set_markup(" " .. markup("#e33a6e", string.format("%3d", cpu_now.usage) .. "% "))
      end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local tempwidget = lain.widgets.temp({
      timeout = 0.5,
      tempfile = "/sys/class/thermal/thermal_zone2/temp",
      settings = function()
         widget:set_markup(" " .. markup("#f1af5f", string.format("%3.1f", coretemp_now) .. "°C "))
      end
})

-- Battery
local baticon = wibox.widget.imagebox(beautiful.widget_batt)
local batwidget = lain.widgets.bat({
      timeout = 0.1,
      batteries = {"BAT1"},
      notify = "on",

      settings = function()
         widget:set_text(" " .. bat_now.perc .. "% " .. bat_now.status .. " ")
      end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(beautiful.widget_vol)
local volumewidget = lain.widgets.alsa({
      timeout = 0.2,
      channel = "Master",
      settings = function()
         if volume_now.status == "off" then
            widget:set_markup(" " .. markup("#7493d2", "0M%"))
         else
            widget:set_markup(" " .. markup("#7493d2", volume_now.level .. "% "))
         end
      end
})
volumewidget:buttons(awful.util.table.join(
                        awful.button({ }, 1, function () awful.util.spawn("amixer -D pulse set Master 1+ toggle") end),
                        awful.button({ }, 4, function () awful.util.spawn("amixer set Master 2%+") end),
                        awful.button({ }, 5, function () awful.util.spawn("amixer set Master 2%-") end)
))

-- Net
--netssid = wibox.widget.textbox()
--netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdowninfo = wibox.widget.textbox()

--netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--[[
netupinfo = lain.widgets.net({
      settings = function()
         file_helper = io.popen("iwgetid -r")
         ssid = file_helper:read("*all")

         if (ssid == "") then
            ssid = "Not connected"
         end

         widget:set_markup(markup("#e54c62", net_now.sent .. " "))
         netssid:set_markup(markup("#cc66ff", ssid .. " "))
         netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
      end
})
]]
--
--netssid:buttons(awful.util.table.join(
--                   awful.button({ }, 1, function () awful.util.spawn("nm-applet") end)
--))

-- MEM
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local memwidget = lain.widgets.mem({
      settings = function()
         widget:set_markup(" " .. markup("#e0da37", string.format("%4d", mem_now.used) .. "M "))
      end
})

-- mpd widget
--[[
mpdicon   = wibox.widget.imagebox(beautiful.widget_note)
mpdwidget = lain.widgets.mpd({
      settings = function()
         mpd_notification_preset = {
            title   = "Now playing",
            timeout = 6,
            text    = string.format("%s (%s) - %s\n%s", mpd_now.artist,
                                    mpd_now.album, mpd_now.date, mpd_now.title)
         }

         widget:set_markup(markup("#e54c62", mpd_now.artist) .. " - " .. markup("#b2b2b2", mpd_now.title) .. " ")
      end
})
]]

-- cmus widget
local cmusicon = wibox.widget.imagebox(beautiful.widget_note)
local cmuswidget = lain.widgets.abase({
      cmd = "cmus-remote -Q",
      timeout = 2,
      settings = function()
         local cmus_now = {
            state   = "N/A",
            artist  = "N/A",
            title   = "N/A",
            album   = "N/A"
         }

         for w in string.gmatch(output, "(.-)tag") do
            local a, b = w:match("(%w+) (.-)\n")
            cmus_now[a] = b
         end

         local artist = cmus_now.artist
         local title  = cmus_now.title

         if utf8.len(title) > 25 then
            title = utf8.sub(title, 0, 25) .. " ..."
         end

         widget:set_markup(" " .. markup("#e54c62", artist) .. " - " .. markup("#b2b2b2", title) .. " ")
      end
})

-- Spacer
local spacer = wibox.widget.textbox(" ")

-- }}}

-- {{{ Layout

-- Create a wibox for each screen and add it
local mywibox = {}
local mybottomwibox = {}

local mypromptbox = {}
local mylayoutbox = {}
local mytasklist  = {}
local mytaglist   = {}

mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() then
               awful.tag.viewonly(c:tags()[1])
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
         end
   end),
   awful.button({ }, 3, function ()
         if instance then
            instance:hide()
            instance = nil
         else
            instance = awful.menu.clients({ width=250 })
         end
   end),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
         if client.focus then client.focus:raise() end
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
         if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
   -- Create a promptbox for each screen
   mypromptbox[s] = awful.widget.prompt()


   -- We need one layoutbox per screen.
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(awful.util.table.join(
                             awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

   -- Create the upper wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s, height = 24 })
   --border_width = 0, height =  20 })

   -- Create the bottom wibox
   mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 24 })

   -- Widgets that are aligned to the upper left
   local left_layout = wibox.layout.fixed.horizontal()
   --left_layout:add(awful.titlebar.widget.iconwidget(c))
   left_layout:add(mytaglist[s])
   left_layout:add(mypromptbox[s])

   -- Widgets that are aligned to the upper right
   local right_layout = wibox.layout.fixed.horizontal()

   -- Add system tray
   if s == 1 then
      right_layout:add(wibox.widget.systray())
   end



   right_layout:add(redshift_widget)
   --right_layout:add(mpdicon)
   --right_layout:add(mpdwidget)
   right_layout:add(cmusicon)
   right_layout:add(cmuswidget)
   --right_layout:add(netssid)
   --right_layout:add(netdownicon)
   --right_layout:add(netdowninfo)
   --right_layout:add(netupicon)
   --right_layout:add(netupinfo)
   right_layout:add(volicon)
   right_layout:add(volumewidget)
   right_layout:add(memicon)
   right_layout:add(memwidget)
   right_layout:add(cpuicon)
   right_layout:add(cpuwidget)
   right_layout:add(fsicon)
   right_layout:add(fswidget)
   right_layout:add(tempicon)
   right_layout:add(tempwidget)
   right_layout:add(weather.icon)
   right_layout:add(weather.widget)
   right_layout:add(baticon)
   right_layout:add(batwidget)
   right_layout:add(clockicon)
   right_layout:add(mytextclock)
   right_layout:add(menu_buttom)

   -- Now bring it all together (with the tasklist in the middle)
   local layout_top = wibox.layout.align.horizontal()
   layout_top:set_left(left_layout)
   --layout:set_middle(mytasklist[s])
   layout_top:set_right(right_layout)

   mywibox[s]:set_widget(layout_top)

   --Layout from bottom wibox


   -- Widgets that are aligned to the bottom left
   local bottom_left_layout = wibox.layout.fixed.horizontal()

   -- Widgets that are aligned to the bottom right
   local bottom_right_layout = wibox.layout.fixed.horizontal()


   bottom_right_layout:add(mylayoutbox[s])

   -- Now bring it all together (with the tasklist in the middle)
   local bottom_layout = wibox.layout.align.horizontal()
   bottom_layout:set_left(bottom_left_layout)
   bottom_layout:set_middle(mytasklist[s])
   bottom_layout:set_right(bottom_right_layout)

   mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
                --awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   -- Take a screenshot
   awful.key({}, "Print", function ()
         awful.util.spawn_with_shell(screenshot)
   end),

   -- Open Revelation

   awful.key({modkey}, "e", rev),

   -- Suspend on pressing sleep key

   awful.key({ }, "XF86Sleep", function() awful.util.spawn_with_shell("mysuspend") end),

   -- Lock Screen
   awful.key({modkey}, "l", function() awful.util.spawn_with_shell("lock") end),

   -- Tag browsing
   awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey }, "Escape", awful.tag.history.restore),

   -- Non-empty tag browsing
   awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
   awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

   -- Default client focus
   awful.key({ altkey }, "k",
      function ()
         awful.client.focus.byidx( 1)
         if client.focus then client.focus:raise() end
   end),
   awful.key({ altkey }, "j",
      function ()
         awful.client.focus.byidx(-1)
         if client.focus then client.focus:raise() end
   end),

   -- By direction client focus
   awful.key({ modkey }, "j",
      function()
         awful.client.focus.bydirection("down")
         if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey }, "k",
      function()
         awful.client.focus.bydirection("up")
         if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey }, "h",
      function()
         awful.client.focus.bydirection("left")
         if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey }, "l",
      function()
         awful.client.focus.bydirection("right")
         if client.focus then client.focus:raise() end
   end),

   -- Show Menu
   awful.key({ modkey }, "w",
      function ()
         mymainmenu:show({ keygrabber = true })
   end),

   -- Show/Hide Wibox
   awful.key({ modkey }, "b", function ()
         mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
         mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
   end),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "Tab",
      function ()
         awful.client.focus.history.previous()
         if client.focus then
            client.focus:raise()
         end
   end),
   awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
   awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
   awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
   awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
   awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
   awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
   awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
   awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
   awful.key({ modkey, "Control" }, "n",      awful.client.restore),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ modkey, "Control" }, "r",      awesome.restart),
   awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

   -- Dropdown terminal
   --awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

   -- ALSA volume control

   awful.key({ }, "XF86AudioRaiseVolume",    function () awful.util.spawn("amixer set Master 2%+") end),
   awful.key({ }, "XF86AudioLowerVolume",    function () awful.util.spawn("amixer set Master 2%-") end),
   awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),

   -- cmus
   awful.key({ }, "XF86AudioPlay",    function () awful.util.spawn("cmus-remote -u") end),
   awful.key({ }, "XF86AudioPrev",    function () awful.util.spawn("cmus-remote -r") end),
   awful.key({ }, "XF86AudioNext",    function () awful.util.spawn("cmus-remote -n") end),

   -- mpd
   --[[
   awful.key({ }, "XF86AudioPlay",
      function ()
         awful.util.spawn("mpc toggle")
         mpdwidget.update()
   end),
   awful.key({ }, "XF86AudioPrev",
      function ()
         awful.util.spawn("mpc prev")
         mpdwidget.update()
   end),
   awful.key({ }, "XF86AudioNext",
      function ()
         awful.util.spawn("mpc next")
         mpdwidget.update()
   end),
   ]]
-- end

-- Add xrandr module to deal with multiple monitor user 'Display' key

awful.key({}, "XF86WWW", function() xrandr.xrandr() end),

-- Copy to clipboard
awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

-- User programs
awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
awful.key({ modkey }, "i", function () awful.util.spawn(browser2) end),
awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
awful.key({ modkey }, "g", function () awful.util.spawn(graphics) end),

-- Prompt
awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
awful.key({ modkey }, "x",
   function ()
      awful.prompt.run({ prompt = "Run Lua code: " },
         mypromptbox[mouse.screen].widget,
         awful.util.eval, nil,
         awful.util.getdir("cache") .. "/history_eval")
end)
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
   awful.key({ modkey,           }, "n",
      function (c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
   end),
   awful.key({ modkey,           }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c.maximized_vertical   = not c.maximized_vertical
   end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = awful.util.table.join(globalkeys,
                                      awful.key({ modkey }, "#" .. i + 9,
                                         function ()
                                            local screen = mouse.screen
                                            local tag = awful.tag.gettags(screen)[i]
                                            if tag then
                                               awful.tag.viewonly(tag)
                                            end
                                      end),
                                      awful.key({ modkey, "Control" }, "#" .. i + 9,
                                         function ()
                                            local screen = mouse.screen
                                            local tag = awful.tag.gettags(screen)[i]
                                            if tag then
                                               awful.tag.viewtoggle(tag)
                                            end
                                      end),
                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                         function ()
                                            local tag = awful.tag.gettags(client.focus.screen)[i]
                                            if client.focus and tag then
                                               awful.client.movetotag(tag)
                                            end
                                      end),
                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                         function ()
                                            local tag = awful.tag.gettags(client.focus.screen)[i]
                                            if client.focus and tag then
                                               awful.client.toggletag(tag)
                                            end
   end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        keys = clientkeys,
        buttons = clientbuttons,
        size_hints_honor = false } },

   { rule = { class = "web", class = "Firefox" },
     properties = { tag = tags[1][1] } },

   { rule = { class = "emacs" },
     properties = { tag = tags[1][2] } },

   { rule = { class = "term" },
     properties = { tag = tags[1][3] } },

   { rule = { class = "doc" },
     properties = { tag = tags[1][4] } },

   { rule = { class = "mail" },
     properties = { tag = tags[1][5] } },

   { rule = { class = "chat", name = "WeeChat 1.2"  },
     properties = { tag = tags[1][6] } },

   { rule = { class = "music", name = "cmus v2.6.0" },
     properties = { tag = tags[1][8] } },

   { rule = { class = "other" },
     properties = { tag = tags[1][9] } },


   { rule = { class = "Gimp", role = "gimp-image-window" },
     properties = { maximized_horizontal = true,
                    maximized_vertical = true } },
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.

client.connect_signal("manage", function (c, startup)
                         -- enable sloppy focus
                         c:connect_signal("mouse::enter", function(c)
                                             if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                             and awful.client.focus.filter(c) then
                                                client.focus = c
                                             end
                         end)

                         if not startup and not c.size_hints.user_position
                         and not c.size_hints.program_position then
                            awful.placement.no_overlap(c)
                            awful.placement.no_offscreen(c)
                         end

                         local titlebars_enabled = true
                         if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
                            -- buttons for the titlebar
                            local buttons = awful.util.table.join(
                               awful.button({ }, 1, function()
                                     client.focus = c
                                     c:raise()
                                     awful.mouse.client.move(c)
                               end),
                               awful.button({ }, 3, function()
                                     client.focus = c
                                     c:raise()
                                     awful.mouse.client.resize(c)
                               end)
                            )

                            -- widgets that are aligned to the right
                            local right_layout = wibox.layout.fixed.horizontal()
                            right_layout:add(awful.titlebar.widget.floatingbutton(c))
                            right_layout:add(awful.titlebar.widget.maximizedbutton(c))
                            right_layout:add(awful.titlebar.widget.stickybutton(c))
                            right_layout:add(awful.titlebar.widget.ontopbutton(c))
                            right_layout:add(awful.titlebar.widget.closebutton(c))

                            -- the title goes in the middle
                            local middle_layout = wibox.layout.flex.horizontal()
                            local title = awful.titlebar.widget.titlewidget(c)
                            title:set_align("center")
                            middle_layout:add(title)
                            middle_layout:buttons(buttons)

                            -- now bring it all together
                            local layout = wibox.layout.align.horizontal()
                            layout:set_right(right_layout)
                            layout:set_middle(middle_layout)

                            awful.titlebar(c,{size=16}):set_widget(layout)
                         end
end)

-- No border for maximized clients
client.connect_signal("focus",
                      function(c)
                         if c.maximized_horizontal == true and c.maximized_vertical == true then
                            c.border_color = beautiful.border_normal
                         else
                            c.border_color = beautiful.border_focus
                         end
end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
                                                         local clients = awful.client.visible(s)
                                                         local layout  = awful.layout.getname(awful.layout.get(s))

                                                         if #clients > 0 then -- Fine grained borders and floaters control
                                                            for _, c in pairs(clients) do -- Floaters always have borders
                                                               -- No borders with only one humanly visible client
                                                               if layout == "max" then
                                                                  c.border_width = 0
                                                               elseif awful.client.floating.get(c) or layout == "floating" then
                                                                  c.border_width = beautiful.border_width
                                                               elseif #clients == 1 then
                                                                  clients[1].border_width = 0
                                                                  if layout ~= "max" then
                                                                     awful.client.moveresize(0, 0, 2, 0, clients[1])
                                                                  end
                                                               else
                                                                  c.border_width = beautiful.border_width
                                                               end
                                                            end
                                                         end
                                                     end)
end
-- }}}

awful.util.spawn_with_shell("xrdb -merge ~/.Xresources")
awful.util.spawn_with_shell('xmodmap -e "keycode 118 ="')
awful.util.spawn_with_shell("urxvtd")

--spawn_once("google-chrome-stable -title web", "web", tags[1][1])

spawn_once("compton", "", tags[1][1])

--spawn_once("emacs -title emacs", "emacs", tags[1][2])
--spawn_once("urxvtc -title term  -e tmux -S /tmp/pair", "term", tags[1][3])
spawn_once("urxvtc -title chat  -e weechat", "chat", tags[1][4])
spawn_once("urxvtc -title music -e cmus", "music", tags[1][5])

spawn_once("nm-applet", "other", tags[1][6])

--spawn_once("xterm -name doc", "doc", tags[1][4])
