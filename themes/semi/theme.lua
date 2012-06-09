-----------------------------------
-- semi's awesome theme #1       --
--                               --
-- is based on the zenburn theme --
-- created by Adrian C. (anrxc)  --
--                               --
-- icons:                        --
-- * silk by famfamfam.com       --
-- * fugue by Yusuke Kamiyamane  --
-----------------------------------

basefolder = "/home/sseemayer/.config/awesome/themes/semi/"

-- {{{ Main
theme = {}
theme.wallpaper_cmd = { "awsetbg " .. basefolder .. "wallpaper.jpg" }
-- }}}

-- {{{ Styles
theme.font      = "Play 9"

-- {{{ Colors
theme.fg_normal = "#a3bfc1"
theme.fg_focus  = "#d5d1d1"
theme.fg_urgent = "#533938"
theme.bg_normal = "#2b2c33"
theme.bg_focus  = "#322020"
theme.bg_urgent = "#c9463f"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#2b2c33"
theme.border_focus  = "#2b2c33"
theme.border_marked = "#2b2c33"
-- }}}

-- {{{ Titlebars
theme.titlebar_fg_focus  = "#d5d1d1"
theme.titlebar_fg_normal = "#eeeeee"
theme.titlebar_bg_focus  = "#322020"
theme.titlebar_bg_normal = "#2b2c33"
-- }}}

theme.tasklist_fg_focus = "#e1c6b8"
theme.tasklisk_bg_focus = "#322020"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

theme.widget_net   = basefolder .. "images/download.png"
theme.widget_netup = basefolder .. "images/upload.png"
theme.widget_cpu   = basefolder .. "images/cpu.png"
theme.widget_mem   = basefolder .. "images/memory.png"
theme.widget_mpd   = basefolder .. "images/mpd.png"
theme.widget_pac   = basefolder .. "images/package.png"

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "16"
theme.menu_width  = "120"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

theme.terminal_icon            = "/usr/share/icons/Faenza/apps/16/terminal.png"
theme.folder_icon            = "/usr/share/icons/Faenza/places/16/folder-home.png"
theme.firefox_icon            = "/usr/share/icons/Faenza/apps/16/firefox.png"
theme.chromium_icon            = "/usr/share/icons/Faenza/apps/16/chromium.png"
theme.squirrelsql_icon            = "/usr/share/icons/Faenza/apps/16/glade.png"
theme.mysql_icon            = "/usr/share/icons/Faenza/apps/16/glade.png"
theme.pidgin_icon            = "/usr/share/icons/Faenza/apps/16/pidgin.png"
theme.empathy_icon            = "/usr/share/icons/Faenza/apps/16/empathy.png"
theme.thunderbird_icon            = "/usr/share/icons/Faenza/apps/16/thunderbird.png"
theme.eclipse_icon            = "/usr/share/icons/Faenza/apps/16/eclipse.png"
theme.gimp_icon            = "/usr/share/icons/Faenza/apps/16/gimp.png"
theme.inkscape_icon            = "/usr/share/icons/Faenza/apps/16/inkscape.png"

-- }}}

-- {{{ Layout
theme.layout_tile       = basefolder .. "layouts/tile.png"
theme.layout_tileleft   = basefolder .. "layouts/tileleft.png"
theme.layout_tilebottom = basefolder .. "layouts/tilebottom.png"
theme.layout_tiletop    = basefolder .. "layouts/tiletop.png"
theme.layout_fairv      = basefolder .. "layouts/fairv.png"
theme.layout_fairh      = basefolder .. "layouts/fairh.png"
theme.layout_spiral     = basefolder .. "layouts/spiral.png"
theme.layout_dwindle    = basefolder .. "layouts/dwindle.png"
theme.layout_max        = basefolder .. "layouts/max.png"
theme.layout_fullscreen = basefolder .. "layouts/fullscreen.png"
theme.layout_magnifier  = basefolder .. "layouts/magnifier.png"
theme.layout_floating   = basefolder .. "layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
