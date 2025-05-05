local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- local emit = wezterm.emit
-- wezterm.emit = function(a, ...)
--     print("emit", a)
--     emit(wezterm, a, ...)
-- end

local function log_proc(proc, indent)
  indent = indent or ''
  wezterm.log_info(
    indent
      .. 'pid='
      .. proc.pid
      .. ', name='
      .. proc.name
      .. ', status='
      .. proc.status
  )
  wezterm.log_info(indent .. 'argv=' .. table.concat(proc.argv, ' '))
  wezterm.log_info(
    indent .. 'executable=' .. proc.executable .. ', cwd=' .. proc.cwd
  )
  for _, child in pairs(proc.children) do
    log_proc(child, indent .. '  ')
  end
end

wezterm.on('mux-is-process-stateful', function(proc)
  log_proc(proc)

  -- Just use the default behavior
  return nil
end)

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- CTRL-SHIFT-l activates the debug overlay
  --{ key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
  --{ key = 'f', mods = 'CTRL', action = wezterm.action_callback(function(win, pane)
  --      print("from within the action callback")
  --  end)
  --  },
  --{ key = '', mods = 'CTRL', action = wezterm.action_callback(function(win, pane)
  --      print("from within the action callback")
  --  end)
  --  },
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },

  {
    key = "v",
    mods = "LEADER",
    action = wezterm.action.SwitchToWorkspace {
      spawn = {
                cwd = "/home/theprimeagen/personal/dev",
        args = { "nvim", "/home/theprimeagen/personal/dev" },
      },
    },
  },

    {
        key = "w",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            wezterm.log_error("wezterm.action.callback start")
            window:perform_action(wezterm.action.SwitchToWorkspace {
                spawn = {
                    cwd = "/home/theprimeagen/personal/dev",
                    args = { "nvim", "/home/theprimeagen/personal/dev/env/.config/wezterm/wezterm.lua" },
                },
            }, pane)
            wezterm.log_error("wezterm.action.callback done")
        end)
    },
}

config.unix_domains = {
  {
    name = "unix",
  },
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { "connect", "unix" }

wezterm.log_error("FRESH CONFIG LOAD!! 11")

-- Your configurations go here
config.font = wezterm.font 'JetBrains Mono'
return config
