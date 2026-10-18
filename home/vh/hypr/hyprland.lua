-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "ghostty"
local browser     = "firefox"
local fileManager = "ghostty -e yazi"
local menu        = "vicinae toggle"
-- pkill -x matches against the kernel's truncated 15-char comm name, so the
-- full 16-char "showmethekey-gtk" never matches -- truncate to match it.
local showKeys    = "pkill -x showmethekey-gt || showmethekey-gtk"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function () 
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
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

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
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

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(

        -- Without this, an already-running app (e.g. Firefox opening an
        -- image via xdg-open) that requests focus/activation just sits on
        -- its workspace unfocused instead of switching you to it.
        focus_on_activate = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    cursor = {
        inactive_timeout = 0, -- Keep the cursor visible when it is idle.
        invisible = false,
        hide_on_key_press = false,
        hide_on_touch = false,
        hide_on_tablet = false,
        no_hardware_cursors = 1, -- Work around cursor disappearing on Hyprland 0.56.x.
        enable_hyprcursor = false, -- Use the regular XCursor theme below.
    },

    input = {
        kb_layout  = "us,ua",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:ctrl_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

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

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd(showKeys))

-- Pin the keys overlay to the top-right corner instead of wherever it opens.
-- Needs float+pin (per upstream docs): Wayland gives clients no protocol to
-- set their own position/layer, so the compositor has to place it.
hl.window_rule({
    name  = "showmethekey-overlay-top-right",
    match = { class = "^(showmethekey-gtk|one\\.alynx\\.showmethekey)$", title = "^(Floating Window.*)$" },
    float = true,
    pin   = true,
    move  = "100%-w 0",
})
-- Keep the settings window floating too, but out of the overlay's way.
hl.window_rule({
    name  = "showmethekey-settings-floating",
    match = { class = "^(showmethekey-gtk|one\\.alynx\\.showmethekey)$", title = "^Show Me The Key$" },
    float = true,
})
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap the active window's position with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Resize the active window with mainMod + CTRL + arrow keys.
-- hl.dsp.window.resize({x=, y=}) takes an ABSOLUTE target size, not a delta,
-- so we read the current size and add the step ourselves.
local resizeStep = 40
local function resizeActiveBy(dx, dy)
    return function()
        local win = hl.get_active_window()
        if not win then return end
        local size = win.size
        hl.dispatch(hl.dsp.window.resize({ x = math.max(1, size.x + dx), y = math.max(1, size.y + dy) }))
    end
end
hl.bind(mainMod .. " + CTRL + left",  resizeActiveBy(-resizeStep, 0), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", resizeActiveBy(resizeStep,  0), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    resizeActiveBy(0, -resizeStep), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  resizeActiveBy(0, resizeStep),  { repeating = true })

-- Apps pinned to specific workspace numbers, keyed by their window class
-- (StartupWMClass / app_id) so we can find an already-running instance.
local workspaceApps = {
    [1] = { class = "firefox",             cmd = browser },
    [2] = { class = "com.mitchellh.ghostty", cmd = terminal },
    [3] = { class = "dev.zed.Zed",         cmd = "zeditor" },
    [4] = { class = "steam",               cmd = "steam" },
    [5] = { class = "Spotify",             cmd = "spotify" },
    [10] = { class = "bitwarden",          cmd = "bitwarden" },
}

-- Focus an existing window of `class` if one exists (switching to its
-- workspace), otherwise launch `cmd` on `workspace`.
local function raiseOrRun(class, cmd, workspace)
    return function()
        local wins = hl.get_windows({ class = class })
        if wins[1] then
            hl.dispatch(hl.dsp.focus({ workspace = wins[1].workspace.id }))
            hl.dispatch(hl.dsp.focus({ window = wins[1] }))
        else
            hl.dispatch(hl.dsp.focus({ workspace = workspace }))
            hl.dispatch(hl.dsp.exec_cmd(cmd))
        end
    end
end

-- mainMod + [0-9]:               raise-or-run that workspace's app
-- mainMod + SHIFT + [0-9]:       launch that workspace's app on the CURRENT workspace
-- Explicit window rules below take precedence over the launch workspace.
-- mainMod + ALT + SHIFT + [0-9]: move the active window to that workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    local app = workspaceApps[i]

    if app then
        hl.bind(mainMod .. " + " .. key, raiseOrRun(app.class, app.cmd, i))
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.exec_cmd(app.cmd))
    else
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    end

    hl.bind(mainMod .. " + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Window groups (tabs): SUPER+G toggles the active window in/out of a group,
-- SUPER+Tab / SUPER+SHIFT+Tab cycle tabs within the group.
hl.bind(mainMod .. " + G",           hl.dsp.group.toggle())
hl.bind(mainMod .. " + Tab",         hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.group.prev())

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Pin Bitwarden to workspace 10 (matches the SUPER+0 raise-or-run binding)
-- so its autostarted window doesn't land wherever happens to be active.
hl.window_rule({
    name  = "bitwarden-workspace",
    match = { class = "^bitwarden$" },
    workspace = "10",
})

-- Steam creates its main window after startup, possibly after we have left
-- workspace 4. Match the client class rather than relying on launch timing
-- or PID-based exec rules, and do not interrupt the current workspace.
hl.window_rule({
    name  = "steam-workspace",
    match = { class = "^steam$" },
    workspace = "4 silent",
})

-- Pin Firefox to workspace 1 (matches the SUPER+1 raise-or-run binding) so
-- windows opened outside that keybind -- e.g. xdg-open'ing an image from a
-- file manager -- still land on the right desktop.
hl.window_rule({
    name  = "firefox-workspace",
    match = { class = "^firefox$" },
    workspace = "1",
})

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
