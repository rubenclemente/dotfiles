-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- ctrl + shift + 5       > right-horizontal
-- ctrl + shift + 2       > down-vertical
-- ctrl + shift + arrows  > navigate
-- ctrl + shift + f       > search


-- Helper function for table merging
local function merge_tables(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, pane)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local color_scheme = window:effective_config().resolved_palette
    
    local bg = color_scheme.background
    local fg = color_scheme.foreground
    local accent = color_scheme.ansi[5]  -- Magenta for accent

    local date = wezterm.strftime('%H:%M:%S')
    local host = wezterm.hostname()

    window:set_right_status(wezterm.format({
        -- Time
        { Background = { Color = 'none' } },
        { Foreground = { Color = accent } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = accent } },
        { Foreground = { Color = bg } },
        { Text = ' ' .. date .. ' ' },
        
        -- Hostname  
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. host .. ' ' },
    }))
end)

return {
    -- Initial geometry for new windows
    initial_cols = 150,
    initial_rows = 60,

    -- Color scheme
    color_scheme = "Catppuccin Macchiato", -- Catppuccin Mocha or Macchiato, Frappe, Latte
    --color_scheme = "Batman",
    -- Alternative good schemes: "Dracula", "OneDark", "Tokyo Night", "Batman", "Gruvbox Dark"

    -- Font configuration
    font = wezterm.font_with_fallback({
        "JetBrains Mono", -- Primary font
        "Fira Code",      -- Fallback font
        "Hack Nerd Font", -- Icons and symbols
    }),
    font_size = 12.0,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- Disable ligatures if preferred

    -- Cursor style
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 800,

    -- Window appearance
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = true,
    tab_bar_at_bottom = false,
    show_new_tab_button_in_tab_bar = false,

    -- window_background_opacity = 0.95,

    -- default: "TITLE | RESIZE"
    window_decorations = "RESIZE",

    -- Window padding
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },

    -- Scrollback
    scrollback_lines = 10000,

    -- Key bindings (similar to common terminals)
    keys = {
        -- Copy/Paste
        { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
        { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

        -- Tab management
        { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
        { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
        { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
        { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

        -- Pane management
        { key = '%', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = '"', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'x', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
        
        -- Pane navigation
        { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
        { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
        { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
        { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

        -- Font size
        { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
        { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
        { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },

        -- Search
        { key = 'f', mods = 'CTRL|SHIFT', action = wezterm.action.Search { CaseSensitiveString = '' } },
    },

    -- Mouse bindings
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'NONE',
            action = wezterm.action.CompleteSelection 'Clipboard',
        },
        {
            event = { Up = { streak = 1, button = 'Right' } },
            mods = 'NONE',
            action = wezterm.action.PasteFrom 'Clipboard',
        },
    },

    -- Default shell (adjust for your system)
    default_prog = { '/bin/bash', '-l' },
    -- For Windows: default_prog = { 'pwsh.exe' } or { 'cmd.exe' }
    -- For Git Bash: default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-l' }

    -- Launch commands when WezTerm starts
    -- set_environment_variables = {
    --     TERM = 'wezterm',
    -- },

    -- Window frame (for Windows/macOS)
    window_frame = {
        font = wezterm.font { family = 'JetBrains Mono', weight = 'Bold' },
        font_size = 12.0,
        active_titlebar_bg = '#1e1e2e',
        inactive_titlebar_bg = '#1e1e2e',
    },

}
