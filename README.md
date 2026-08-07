# Quickshell config

I want to make some [quickshell](https://quickshell.org) config

This config aims for a laptop with 1366x768 monitor.

## Features

- Workspace number on the left
- Hour clock in the middle
- Some info on the right:
  - Battery level
  - Bluetooth

## Disclaimer

THIS CONFIG MIGHT JUST NOT WORK ON YOUR MACHINE!

## How to

### Prerequisite

- A working machine
- Is using [Hyprland](https://hypr.land)
- Have quickshell installed
- Have `CaskaydiaCove Nerd Font Propo` installed. Install it on https://nerdfonts.com or use your favorite package manager.

### Step by step

1. Clone the repo

```bash
git clone https://github.com/thqnhz/quickshell-config
cd quickshell-config
```

2. Kill your quickshell instances

```sh
qs kill --all
```

3. Stow or symlink

3.1. Move your quickshell config if you have it

```sh
mv ~/.config/quickshell ~/backup/quickshell
```

3.2. Do it

```sh
# Using GNU stow
stow quickshell

# Symlink yourself
ln -s quickshell/.config/quickshell ~/.config/quickshell
```

4. Run quickshell

```sh
qs & disown
```

5. You probably have this already. Put qs on your hyprland exec

```lua
hl.on("hyprland.start", function ()
    hl.exec_cmd("qs")
)
```

