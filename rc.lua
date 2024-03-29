
require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("eminent")
require("naughty")
require("vicious")
require("cal")

-- awful.util.spawn_with_shell("xcompmgr &")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
mytheme = "/home/seemayer/.config/awesome/themes/semi/theme.lua"
beautiful.init(mytheme)
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   --tags[s] = awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, layouts[1])
   tags[s] = awful.tag({ "eins", "zwei", "drei", "vier", "fünf", "sechs", "sieben", "acht", "neun" }, s, layouts[1])
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
--
menuseparator = { "-------", nil }

myawesomemenu = {
--   { "manual", terminal .. " -x man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "edit theme", editor_cmd .. " " .. mytheme },
   -- menuseparator,
   { "restart", awesome.restart },
   { "log off", awesome.quit },
   { "shut down...", '/home/seemayer/bin/shutdown_dialog' },
}

iconbase = "/usr/share/icons/Faenza/apps/16/"

menu_internet = {
	{ "&firefox", "firefox", image(iconbase .."firefox.png") },
	{ "&thunderbird", "thunderbird", image(iconbase .. "thunderbird.png")},
	{ "&skype", "skype", image(iconbase .. "skype.png")},
}

menu_dev = {
	{ "&eclipse", "eclipse", image(iconbase .. "eclipse.png")},
	{ "&virt-manager", "virt-manager", image(iconbase .. "virtualbox.png")},
}

menu_graphics = {
	{ "&gimp", "gimp" , image(iconbase .. "gimp.png")},
	{ "&inkscape", "inkscape" , image(iconbase .. "inkscape.png")},
	{ "&pinta", "pinta" , image("/usr/share/pixmaps/pinta.xpm")},

}

mymainmenu = awful.menu({ items = {
				    { "&home", "thunar", image("/usr/share/icons/Faenza/places/16/folder-home.png")},
                                    { "&terminal", terminal, image(iconbase .. "terminal.png") },
				    -- menuseparator,
                                    { "&internet", menu_internet },
				    { "&develop", menu_dev },
				    { "&graphics", menu_graphics },
		                    { "&awesome", myawesomemenu, beautiful.awesome_icon },
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox

-- Create a Network widget
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon.image = image(beautiful.widget_netup)

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 3)

-- Create a Memory widget
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '<span color="#999eff">mem $1%</span>', 5)

-- Create a CPU widget
cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, '<span color="#CC9393">cpu $1% </span> ', 2)

-- Create an MPD widget
mpd_pass = string.match(os.getenv("MPD_HOST"), "^(.+)@")

mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
	function (widget, args)
		if args["{state}"] == "Stop" then 
			return '<span color="#ba82e1"></span>'
		else 
			return '<span color="#ba82e1"> ' .. args["{Artist}"]..' - '.. args["{Title}"] .. " </span>"
		end
	end, 3, {password=mpd_pass})

-- Pacman Widget
pacwidget = widget({type="textbox"})
vicious.register(pacwidget, vicious.widgets.pkg, '<span color="#FFCC00">pac $1 </span>', 60, "Arch")

-- Keyboard layout widget
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { "us", "de" }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = widget({ type = "textbox", align = "right" })
kbdcfg.widget.text = '<span color="#adde97"> ' .. kbdcfg.layout[kbdcfg.current] .. " </span>"
kbdcfg.switch = function ()
kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
local t = kbdcfg.layout[kbdcfg.current]
kbdcfg.widget.text = '<span color="#adde97"> ' .. t .. " </span>"
os.execute( kbdcfg.cmd .. " " .. t )
end

-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
awful.button({ }, 1, function () kbdcfg.switch() end)
))


-- Create a textclock widget
mytextclock = widget({ type = "textbox" })
vicious.register(mytextclock, vicious.widgets.date, "%a %b %e  %k:%M:%S  ", 1)
cal.register(mytextclock)

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
	upicon, netwidget, dnicon,
	memwidget, cpuwidget, pacwidget, kbdcfg.widget, mpdwidget,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(

--  awful.button({ }, 1, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),


    -- Keyboard layout switch
    awful.key({ "Mod1"		  }, "Shift_L", function () kbdcfg.switch()  end ),

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

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    awful.key({ }, "XF86AudioRaiseVolume", function() awful.util.spawn_with_shell('/home/seemayer/bin/volume up') end ),
    awful.key({ }, "XF86AudioLowerVolume", function() awful.util.spawn_with_shell('/home/seemayer/bin/volume down') end ),
    awful.key({ }, "XF86AudioMute", function() awful.util.spawn_with_shell('/home/seemayer/bin/volume mute') end ),
    
    awful.key({ modkey,		  }, "s", function () awful.util.spawn("sonata") end ),
    awful.key({ modkey,		  }, "p", function () awful.util.spawn("mpc toggle") end ),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.util.spawn("mpc prev") end ),
    awful.key({ modkey, "Shift"   }, "Right",  function () awful.util.spawn("mpc next") end ),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

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
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
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

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
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
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons, 
	     	     size_hints_honor = false
	     } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },

    { rule = { class = "Sonata" },
      properties = { floating = true } },
   
    { rule = { class = "docky" },
      properties = { floating = true, ontop = true } }, 

    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awesome.font = theme.font
-- }}}
