# AGENTS.md - Agent Coding Guidelines for This Repository

## Overview

This is a **dotfiles repository** that uses [GNU Stow](https://www.gnu.org/software/stow/) to manage configuration files for various Linux tools. The repository contains configuration files for sway, waybar, alacritty, wofi, nvim, and other Linux applications.

## Repository Structure

```
dotfiles/
├── alacritty/         # Terminal emulator config
├── bash/              # Bash shell configuration
├── fcitx5/            # Chinese input method config
├── fontconfig/        # Font configuration
├── gtk-3.0/           # GTK3 theme settings
├── gtk-4.0/           # GTK4 theme settings
├── nvim/              # Neovim editor config
├── sway/              # Wayland window manager
│   └── scripts/       # Shell scripts for sway automation
├── waybar/            # Status bar for Wayland
└── wofi/              # Application launcher
```

## Build/Lint/Test Commands

### Stow Management

This repository uses GNU Stow to manage symlinks. There is no traditional build process.

```bash
# Stow all packages (create symlinks in home directory)
stow -t ~ alacritty bash fcitx5 fontconfig gtk-3.0 gtk-4.0 nvim sway waybar wofi

# Stow specific packages
stow -t ~ sway waybar

# Unstow (remove symlinks)
stow -t ~ -D alacritty

# Restow (refresh symlinks)
stow -t ~ -R sway

# Dry run (preview without making changes)
stow -t ~ -n sway
```

### Shell Script Testing

For shell scripts in `sway/scripts/`:

```bash
# Syntax check bash scripts
bash -n script.sh

# Run shellcheck if available
shellcheck script.sh

# Make script executable
chmod +x script.sh

# Test script manually
./script.sh
```

### Sway Configuration

```bash
# Validate sway config
swaymsg -t get_inputs  # Quick check sway is running

# Reload sway config (in running sway session)
swaymsg reload
```

### Git Commands

```bash
# Commit changes
git add <files> && git commit -m "Description"

# Push to remote
git push
```

## Code Style Guidelines

### Shell Scripts (bash)

Follow these conventions for shell scripts in `sway/scripts/`:

1. **Shebang**: Use `#!/bin/bash`
2. **Comments**: Add descriptive comments at the top and for complex logic
3. **Variables**: Use UPPERCASE for constants, lowercase for local variables
4. **Error Handling**: Redirect stderr with `2>/dev/null` when appropriate
5. **Functions**: Use `local` for function-scope variables
6. **Quotes**: Use double quotes for variable expansion, single quotes for literal strings

Example:
```bash
#!/bin/bash
# Script description - what it does

CONSTANT_VALUE="fixed"
LOCAL_VAR=""

function my_function() {
    local result
    result=$(some_command 2>/dev/null)
    echo "$result"
}
```

### Sway Configuration

1. **Modularity**: Split into files in `config.d/` (e.g., `key-bindings.conf`, `theme.conf`)
2. **Variables**: Define with `set $name value`
3. **Comments**: Use `#` for comments, `###` for section headers
4. **Quotes**: Use single quotes for commands with spaces

Example:
```bash
# Variables
set $mod Mod4
set $term alacritty

### Key bindings
bindsym $mod+Return exec $term
```

### JSON/JSONC Files (waybar, etc.)

1. **Comments**: JSONC supports `//` comments
2. **Formatting**: Use consistent indentation (2 spaces typical)
3. **Trailing Commas**: Avoid trailing commas in arrays/objects

### TOML Files (alacritty)

1. **Indentation**: Use spaces (not tabs)
2. **Tables**: Use `[table.name]` syntax
3. **Values**: Follow TOML specification

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Shell scripts | `kebab-case.sh` | `lid-handler.sh`, `reset-external-outputs.sh` |
| Config files | `kebab-case.conf` | `key-bindings.conf`, `idle.conf` |
| Variables (sway) | `$lowercase` | `$mod`, `$term` |
| Constants (bash) | `UPPERCASE` | `LAPTOP_SCREEN` |

## Error Handling

### Shell Scripts
- Use `||` for fallback commands: `cmd1 || cmd2`
- Redirect stderr when errors are expected: `command 2>/dev/null`
- Use exit codes: `exit 0` for success, `exit 1` for failure
- Use traps for cleanup: `trap "rm -f $lockfile" EXIT`

### Sway Config
- Test commands manually before adding to config
- Use absolute paths (`$HOME/...`) instead of `~` (tilde doesn't expand)
- Include error redirection for commands that may fail: `exec command 2>/dev/null`

## Important Notes

1. **No ~ expansion**: In sway config, use `$HOME` instead of `~`
2. **Executable scripts**: Scripts in `sway/scripts/` must be executable (`chmod +x`)
3. **Stow target**: Always use `-t ~` when running stow commands
4. **Backup existing configs**: Before stowing, backup existing config directories
5. **Reload sway**: Use `swaymsg reload` after modifying sway config

## Workflow for Adding New Configurations

1. Create or modify files in the appropriate package directory
2. Test changes manually if possible
3. Run `stow -t ~ -n <package>` to preview changes
4. Run `stow -t ~ <package>` to apply symlinks
5. Reload affected services (e.g., `swaymsg reload` for sway)
6. Commit and push changes

## Common Tasks

### Add a new sway script
```bash
# 1. Create script in sway/.config/sway/scripts/
# 2. Make executable: chmod +x script.sh
# 3. Add to sway config: exec ~/.config/sway/scripts/script.sh
# 4. Test: Run script manually first
```

### Add a new sway config file
```bash
# 1. Create file in sway/.config/sway/config.d/
# 2. File is automatically included by main config
# 3. Reload: swaymsg reload
```

### Modify existing package
```bash
# 1. Edit files in package directory
# 2. Restow: stow -t ~ -R <package>
# 3. Test changes
```
