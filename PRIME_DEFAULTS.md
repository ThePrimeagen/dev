# Prime Defaults

Personal Omarchy overrides. The distro does not ship these.

Canonical copy: `~/personal/dev/PRIME_DEFAULTS.md`  
Live symlink: `~/.config/PRIME_DEFAULTS.md`

| File | After a reset |
|------|----------------|
| `~/.config/hypr/bindings.lua` | Paste the Lua below, then `hyprctl reload` |
| `~/.config/hypr/input.lua` | Paste the input Lua below, then `hyprctl reload` |
| `~/.config/omarchy/shell.json` | Set `idle.lock` as below. The shell hot-reloads on save. |

## Binds

| Key | Action |
|-----|--------|
| Super+q | Open terminal |
| Super+d | Omarchy menu (same as Super+Space) |
| Super+m | Move current workspace to the next physical monitor (skips OBS-WS) |
| Super+1..0 | Switch workspace, pulling it off OBS-WS if it landed there |
| Super+Shift+Alt+arrows | Move workspace to a physical monitor only (skips OBS-WS) |
| Super+s | Run hyprshot (region, clipboard only) |
| Super+Alt+o | Send the active window to OBS record workspace 11 |
| Super+Ctrl+o | Toggle workspace 11 onto this monitor / park it on OBS-WS |

```lua
-- Super+q: open terminal (Omarchy also keeps Super+Return)
o.bind("SUPER + Q", "Terminal", { omarchy = "terminal" })

-- Super+m: move current workspace to the next physical monitor (skips OBS-WS)
o.bind("SUPER + M", "Move workspace to next physical monitor", "obs-workspace move-physical")

for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  hl.unbind("SUPER + " .. key)
  o.bind(
    "SUPER + " .. key,
    "Switch to workspace " .. workspace,
    "obs-workspace switch " .. workspace
  )
end

hl.unbind("SUPER + SHIFT + ALT + LEFT")
hl.unbind("SUPER + SHIFT + ALT + RIGHT")
hl.unbind("SUPER + SHIFT + ALT + UP")
hl.unbind("SUPER + SHIFT + ALT + DOWN")
o.bind("SUPER + SHIFT + ALT + LEFT", "Move workspace to left physical monitor", "obs-workspace move-physical-dir l")
o.bind("SUPER + SHIFT + ALT + RIGHT", "Move workspace to right physical monitor", "obs-workspace move-physical-dir r")
o.bind("SUPER + SHIFT + ALT + UP", "Move workspace to up physical monitor", "obs-workspace move-physical-dir u")
o.bind("SUPER + SHIFT + ALT + DOWN", "Move workspace to down physical monitor", "obs-workspace move-physical-dir d")

-- Super+s: hyprshot (Omarchy default Super+S is toggle scratchpad)
hl.unbind("SUPER + S")
o.bind("SUPER + S", "Screenshot", "hyprshot -m region --clipboard-only")

-- Super+d: same as Super+Space (Omarchy menu)
o.bind("SUPER + D", "Omarchy menu", "omarchy-menu toggle")

-- OBS workspace 11 lives on the headless OBS-WS output.
o.bind("SUPER + ALT + O", "Send window to OBS record workspace", "obs-workspace send")
o.bind("SUPER + CTRL + O", "Toggle OBS record workspace on this monitor", "obs-workspace toggle")

hl.unbind("CTRL + ALT + TAB")
hl.unbind("CTRL + ALT + SHIFT + TAB")
o.bind("CTRL + ALT + TAB", "Focus next physical monitor", "obs-workspace focus-physical +1")
o.bind("CTRL + ALT + SHIFT + TAB", "Focus previous physical monitor", "obs-workspace focus-physical -1")
```

### Bind overrides

- Super+s replaces Omarchy's **toggle scratchpad**. Move a window to the scratchpad is still Super+Alt+s.
- Super+q is extra. Super+Return still opens a terminal via `omarchy-launch-terminal`.
- Super+m is unbound in current Omarchy Lua defaults. It now skips the OBS-WS headless output.
- Super+1..0 and Super+Shift+Alt+arrows skip OBS-WS so an unplug or “monitor to the right” cannot hide workspaces 1-10.
- Super+d is extra. Super+Space still opens the Omarchy menu.
- Ctrl+Alt+Tab previously focused the next monitor, including OBS-WS. It now cycles physical monitors only.

## Keyboard

Caps Lock is Control. Omarchy's default is Caps as compose (`compose:caps`) with both Shifts as Caps Lock (`shift:both_capslock_cancel`).

In `~/.config/hypr/input.lua`:

```lua
-- Caps Lock is Control. Replaces Omarchy's compose:caps + shift:both_capslock_cancel.
hl.config({
  input = {
    kb_options = "ctrl:nocaps",
  },
})
```

- `ctrl:nocaps` is an XKB option. Caps Lock becomes Control. There is no Caps Lock key.
- This replaces the whole `kb_options` string. If you add a non-Latin layout, append `,grp:alts_toggle` again.

## Idle

Do not lock the session until **30 minutes** of inactivity. Omarchy's default is 5 minutes (`300`).

In `~/.config/omarchy/shell.json`:

```json
"idle": {
  "screensaver": 150,
  "lock": 1800
}
```

- `lock` is seconds since idle began. `1800` = 30 minutes.
- Screensaver still starts at 150 seconds (2.5 minutes). That is not the lock screen.
- Super+Ctrl+I still toggles idle lock off entirely (stay-awake).
