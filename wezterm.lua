local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

config.window_decorations = 'RESIZE'

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7
}

config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 14
config.line_height = 1.2

config.use_dead_keys = false
config.scrollback_lines = 5000

config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
}

--config.launch_menu = launch_menu

--config.default_cursor_style = 'BlinkingBar'
config.disable_default_key_bindings = true
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 2000 }

config.keys = {
  { key = 'l', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'h', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'j', mods = 'CMD', action = act.ActivatePaneDirection 'Down', },
  { key = 'k', mods = 'CMD', action = act.ActivatePaneDirection 'Up', },
  { key = 'Enter', mods = 'CMD', action = act.ActivateCopyMode },
  { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'f', mods = 'CMD', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = 'h', mods = 'CMD', action = act.ActivatePaneDirection 'Left', },
  { key = 'l', mods = 'CMD', action = act.ActivatePaneDirection 'Right', },
  { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentTab{ confirm = false } },
  { key = 'x', mods = 'CMD', action = act.CloseCurrentPane{ confirm = false } },
  { key = 'b', mods = 'LEADER|CTRL', action = act.SendString '\x02', },
  { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode, },
  { key = 'p', mods = 'LEADER', action = act.PasteFrom("Clipboard"), },
--  { key = 'k', mods = 'CTRL|ALT', action = act.Multiple,
--    {
--      act.ClearScrollback 'ScrollbackAndViewport',
--      act.SendKey { key = 'L', mods = 'CTRL' },
--    },
--  },
}

--{ key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, }
config.mouse_bindings = mouse_bindings

mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.5,
  brightness = 1.8,
}

local terminalBackgroundFilePath = 'C:/Users/mmand/Pictures/dark-souls-3-1080p.jpg'
config.background = {
  {
    source = { File = {path = terminalBackgroundFilePath, speed = 0.2}},
    opacity = 1,
    width = "100%",
    hsb = {brightness = 0.3},
  }
}

--config.default_domain = 'powershell.exe'
--config.default_prog = { 'powershell' }

return config
