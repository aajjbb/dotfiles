
-- @DOC_REQUIRE_SECTION@
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Libs
local lain           = require("lain")
local rev            = require("awesome-revelation")
local xrandr         = require("xrandr")
local utf8           = require 'lua-utf8'
local lain_icons_dir = require("lain.helpers").icons_dir

-- {{{ Error handling
-- @DOC_ERROR_HANDLING@
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
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
-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
-- localization
os.setlocale(os.getenv("LANG"))

--beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/starbreaker/theme.lua")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/awesome-copycats/themes/multicolor/theme.lua")

-- Define Useless Gap
beautiful.useless_gap = 3

--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")

-- @DOC_DEFAULT_APPLICATIONS@
-- This is used later as the default terminal and editor to run.

-- awesome-revelation init
rev.init()

-- common
local markup     = lain.util.markup
local modkey     = "Mod4"
local altkey     = "Mod1"
local terminal   = "urxvtc" or "xterm"

-- user defined
local editor_cmd = "vim"
local browser = "google-chrome-stable"
local gui_editor = "emacs"
local mail = "thunderbird"
local word_processor = "libreoffice --writer"
local music = "cmus"
local files = "caja --no-desktop"
local screenshot = "scrot -q 100 '%Y-%m-%d-%k-%M-%S_$wx$h.png' -e 'mv $f ~/Pictures/Screenshot/'"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- @DOC_LAYOUT@
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,

    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- @DOC_MENU@
-- Create a launcher widget and a main menu

-- XDG Menu

myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.menu_submenu_icon },
                             { "open terminal", terminal },
                             { "music", music },
                             { "files", files },
                             { "text editor", gui_editor },
                             { "word processor", word_processor },
                             { "web browser", browser },
                             { "lightweight browser", browser2 },
                             { "mail", mail },
                             { "im", im },
}
                        }
                       )

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
-- @TAGLIST_BUTTON@
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- @TASKLIST_BUTTON@
local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- @DOC_WALLPAPER@

wp_index = 1
wp_timeout  = 40
wp_path = os.getenv("HOME") .. "/.config/awesome/themes/starbreaker/"
wp_files = {
   "1.jpg",
   "2.jpg",
   "3.jpg",
   "4.jpg"
}

local function set_wallpaper(s)
   -- Random Wallpaper
   -- configuration - edit to your liking

   -- setup the timer
   local wp_timer = timer { timeout = wp_timeout }
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
   wp_timer:start()
    -- Wallpaper
    -- if beautiful.wallpaper then
    --     local wallpaper = beautiful.wallpaper
    --     -- If wallpaper is a function, call it with the screen
    --     if type(wallpaper) == "function" then
    --         wallpaper = wallpaper(s)
    --     end
    --     gears.wallpaper.maximized(wallpaper, s, true)
    -- end
end

-- Widgets

-- Menu buttom

local menu_buttom = wibox.widget.imagebox(beautiful.menu_submenu_icon)

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
      timeout = 10,
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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- @DOC_FOR_EACH_SCREEN@
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"web",
               "emacs",
               "term",
               "chat",
               "twitt",
               "music",
               "docs",
               "other",
              }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- @DOC_WIBAR@
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 22 })

    -- Create bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = 22 })

    -- @DOC_SETUP_WIDGETS@
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        {
           layout = wibox.layout.align.horizontal,
        },
        { -- Right widgets
           layout = wibox.layout.fixed.horizontal,
           wibox.widget.systray(),
           mykeyboardlayout,
           --Widgets
           redshift_widget,
           cmusicon,
           cmuswidget,
           volicon,
           volumewidget,
           memicon,
           memwidget,
           fsicon,
           fswidget,
           tempicon,
           tempwidget,
           weather.icon,
           weather.widget,
           baticon,
           batwidget,
           clockicon,
           mytextclock,
           menu_buttom,
        },
    }
    s.mybottomwibox:setup {
       layout = wibox.layout.align.horizontal,
       {
          layout = wibox.layout.align.horizontal,
       },
       {
          layout = wibox.layout.align.horizontal,
          s.mytasklist, -- Middle widget
       },
       {
          layout = wibox.layout.align.horizontal,
          s.mylayoutbox,
       }
    }
end)
-- }}}

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
       {description = "show the menubar", group = "launcher"}),

    -- My personal keybindings

    -- Dynamic Tagging

    awful.key({ modkey }, "t", function()
          awful.tag.add("Temp")
                               end),


    -- Audio Keys
    awful.key({ }, "XF86AudioRaiseVolume",    function () awful.util.spawn("amixer set Master 2%+") end),
    awful.key({ }, "XF86AudioLowerVolume",    function () awful.util.spawn("amixer set Master 2%-") end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),

    -- cmus
    awful.key({ }, "XF86AudioPlay",    function () awful.util.spawn("cmus-remote -u") end),
    awful.key({ }, "XF86AudioPrev",    function () awful.util.spawn("cmus-remote -r") end),
    awful.key({ }, "XF86AudioNext",    function () awful.util.spawn("cmus-remote -n") end),

    -- Working with multiple screens
    awful.key({}, "XF86WWW", function() xrandr.xrandr() end),

    -- Take a screenshot
    awful.key({}, "Print", function ()
          awful.util.spawn_with_shell(screenshot)
    end),

    -- Open Revelation
    awful.key({modkey}, "e", rev),

    -- Suspend on pressing sleep key
    awful.key({ }, "XF86Sleep", function() awful.util.spawn_with_shell("mysuspend") end),

    -- Lock Screen
    awful.key({modkey}, "l", function() awful.util.spawn_with_shell("lock") end)

)

-- @DOC_CLIENT_KEYBINDINGS@
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- @DOC_NUMBER_KEYBINDINGS@
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- @DOC_CLIENT_BUTTONS@
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- @DOC_RULES@
awful.rules.rules = {
    -- @DOC_GLOBAL_RULE@
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- @DOC_FLOATING_RULE@
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- @DOC_DIALOG_RULE@
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
-- @DOC_MANAGE_HOOK@
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- @DOC_TITLEBARS@
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
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

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- @DOC_BORDER@
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{ Autorun

awful.util.spawn_with_shell("xrdb -merge ~/.Xresources")
awful.util.spawn_with_shell('xmodmap -e "keycode 118 ="')
awful.util.spawn_with_shell("urxvtd")
awful.util.spawn_with_shell("nm-applet")

-- }}
