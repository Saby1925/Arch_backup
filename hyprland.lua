-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- HYPRLAND LUA CONFIGURATION                             --
-- Dynamic Layouts, Window Grouping & Full Bindings       --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "0.83",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "hyprlauncher"
local browser     = "firefox"
local colors = require('colors')

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar & awww-daemon & hypridle")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,
        border_size = 2,

        col = {
            active_border   =colors.primary, 
           inactive_border =colors.outline,
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       =10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    group = {
        col = {
            border_active   = "rgba(00ff99ee)",
            border_inactive = "rgba(595959aa)",
        },
        groupbar = {
            font_size = 10,
            gradients = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-----------------------------------
---- LAYOUT SPECIFIC CONFIGS ------
-----------------------------------

-- Dwindle Layout
hl.config({
    dwindle = {
        preserve_split = true,
        force_split = 2,
        special_scale_factor = 0.8,
    },
})

-- Master Layout
hl.config({
    master = {
        new_status = "slave",
        new_on_top = false,
        mfact = 0.55,
        orientation = "left",
    },
})

-- Scrolling Layout
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

---------------------------------------------
---- DYNAMIC LAYOUT TOGGLE FUNCTIONALITY ----
---------------------------------------------

local layouts = { "dwindle", "master", "scrolling" }
local current_layout_idx = 1

local function toggle_layout()
    current_layout_idx = (current_layout_idx % #layouts) + 1
    local next_layout = layouts[current_layout_idx]

    hl.config({
        general = {
            layout = next_layout
        }
    })

    hl.exec_cmd(string.format("notify-send 'Hyprland Layout' '%s'", next_layout:upper()))
end

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Core Application Binds
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + b",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd("rofi -show drun"))

hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
-- System / Session Controls
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- Window State / Layout Adjustments
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + t", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Dynamic Layout Switcher (Cycles: Dwindle -> Master -> Scrolling -> Monocle)
hl.bind(mainMod .. " + Y", toggle_layout, { description = "Cycle layout" })

---------------------------------
---- WINDOW GROUPING (TABS) -----
---------------------------------

-- SUPER + G
hl.bind(
    mainMod .. " + G",
    hl.dsp.group.toggle()
)

-- SUPER + SHIFT + G
hl.bind(
    mainMod .. " + SHIFT + G",
    hl.dsp.group.lock({
        action = "toggle"
    })
)

-- SUPER + TAB
hl.bind(
    mainMod .. " + TAB",
    hl.dsp.group.next(),
    {
        repeating = true
    }
)

-- SUPER + SHIFT + TAB
hl.bind(
    mainMod .. " + SHIFT + TAB",
    hl.dsp.group.prev(),
    {
        repeating = true
    }
)

-- Move window into group
hl.bind(
    mainMod .. " + ALT + left",
    hl.dsp.window.move({
        into_group = "l"
    })
)

hl.bind(
    mainMod .. " + ALT + right",
    hl.dsp.window.move({
        into_group = "r"
    })
)

hl.bind(
    mainMod .. " + ALT + up",
    hl.dsp.window.move({
        into_group = "u"
    })
)

hl.bind(
    mainMod .. " + ALT + down",
    hl.dsp.window.move({
        into_group = "d"
    })
)

-- SUPER + ALT + O
-- Remove active window from its group
hl.bind(
    mainMod .. " + ALT + O",
    hl.dsp.window.move({
        out_of_group = true
    })
)

------------------------------
---- NAVIGATION & FOCUS ------
------------------------------

-- Focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Focus with Vim keys (HJKL)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-------------------------------------
---- MOVE WINDOWS: SUPER + SHIFT ---
-------------------------------------

hl.bind(
    mainMod .. " + SHIFT + h",
    hl.dsp.window.move({
        direction = "l"
    }),
    {
        repeating = true
    }
)

hl.bind(
    mainMod .. " + SHIFT + l",
    hl.dsp.window.move({
        direction = "r"
    }),
    {
        repeating = true
    }
)

hl.bind(
    mainMod .. " + SHIFT + k",
    hl.dsp.window.move({
        direction = "u"
    }),
    {
        repeating = true
    }
)

hl.bind(
    mainMod .. " + SHIFT + j",
    hl.dsp.window.move({
        direction = "d"
    }),
    {
        repeating = true
    }
)

------------------------------------
---- RESIZE WINDOWS: SUPER + ALT ---
------------------------------------

-- Use Hyprland's native resizeactive dispatcher through exec_cmd.
-- This avoids relying on an unsupported window.resize(x/y) Lua signature.

hl.bind(
    mainMod .. " + ALT + h",
    hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
    { repeating = true }
)

hl.bind(
    mainMod .. " + ALT + l",
    hl.dsp.window.resize({ x = 20, y = 0, relative = true }),
    { repeating = true }
)

hl.bind(
    mainMod .. " + ALT + k",
    hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
    { repeating = true }
)

hl.bind(
    mainMod .. " + ALT + j",
    hl.dsp.window.resize({ x = 0, y = 20, relative = true }),
    { repeating = true }
)


-- Workspaces Navigation (1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspace Scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Window Control
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------------
---- MEDIA & HARDWARE KEYS ---
------------------------------

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("sh -c 'f=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png; grim \"$f\" && notify-send \"Screenshot saved\" \"$f\"'"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("sh -c 'f=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png; grim -g \"$(slurp)\" \"$f\"' && notify-send \"Screenshot saved\" \"$f\""))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send \"Screenshot copied to clipboard\"'"))
