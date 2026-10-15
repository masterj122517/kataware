# Kataware

A comet-lit indigo night for Vim, Neovim, Yazi, Ghostty, and tmux.

## Vim

Copy the Vimscript colorscheme into your Vim configuration:

```sh
mkdir -p ~/.vim/colors
cp colors/kataware.vim ~/.vim/colors/kataware.vim
```

Add this to your `~/.vimrc`:

```vim
syntax enable
if exists('+termguicolors')
  set termguicolors
endif
colorscheme kataware
```

The theme supports GUI/true-color rendering and a 256-color terminal fallback. For a terminal without true-color support, omit `set termguicolors` and use a terminal configured for 256 colors.

Kataware is opaque by default. To enable transparency, set the option before loading the colorscheme:

```vim
let g:kataware_transparent = 1
colorscheme kataware
```

To toggle transparency at runtime:

```vim
let g:kataware_transparent = !get(g:, 'kataware_transparent', 0)
colorscheme kataware
```

Transparent mode clears the editor canvas, sign and fold columns, completion menu, popup notifications, terminal background, and tabline fill. Selected rows, searches, diffs, and statuslines keep their backgrounds for readability. The palette also applies to Vim's built-in terminal buffers.

When installed as a plugin in Neovim, the Vimscript entrypoint delegates to `colors/kataware.lua`, preserving the existing Treesitter, LSP, and plugin highlights. Neovim-only manual installations can continue to use just the Lua file.

## Neovim

Install with `lazy.nvim`:

```lua
{
  'masterj122517/kataware',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'kataware'
  end,
}
```

Kataware is opaque by default. Enable transparency before loading the colorscheme:

```lua
vim.g.kataware_transparent = true
vim.cmd.colorscheme 'kataware'
```

With `lazy.nvim`:

```lua
{
  'masterj122517/kataware',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.kataware_transparent = true
    vim.cmd.colorscheme 'kataware'
  end,
}
```

To switch at runtime, update the option and reload the colorscheme:

```lua
vim.g.kataware_transparent = not vim.g.kataware_transparent
vim.cmd.colorscheme 'kataware'
```

Transparent mode clears the editor canvas, generic floating windows, Telescope, completion menus, WhichKey, sign and fold columns, window bars, and tabline fill. Selected rows, semantic highlights, diagnostics, and statuslines keep their backgrounds for contrast and readability.

For a manual installation, copy `colors/kataware.lua` to `~/.config/nvim/colors/kataware.lua`.

## Yazi

Copy both Yazi files into your configuration directory:

```sh
cp yazi/theme.toml ~/.config/yazi/theme.toml
cp yazi/Kataware.tmTheme ~/.config/yazi/Kataware.tmTheme
```

The included `theme.toml` references `~/.config/yazi/Kataware.tmTheme` for preview syntax highlighting.

## Ghostty

Copy the theme and select it in your Ghostty configuration:

```sh
mkdir -p ~/.config/ghostty/themes
cp ghostty/Kataware ~/.config/ghostty/themes/Kataware
```

```ini
theme = Kataware
```

Native text selection uses a `#2B3B62` indigo background and `#EEF3FF` starlight foreground. The tmux theme below uses the same colors for copy-mode selection.

Ghostty controls terminal transparency separately from color themes:

```ini
background-opacity = 0.8
background-blur = 32
```

## tmux

Copy the theme:

```sh
mkdir -p ~/.config/tmux
cp tmux/kataware.conf ~/.config/tmux/kataware.conf
```

Add this to your tmux configuration (`~/.tmux.conf` or `~/.config/tmux/tmux.conf`), **after** other themes and plugin initialization:

```tmux
source-file ~/.config/tmux/kataware.conf
```

Apply it to a running tmux server:

```sh
tmux source-file ~/.config/tmux/kataware.conf
```

| Surface | Foreground | Background |
| --- | --- | --- |
| Copy-mode selection | Starlight `#EEF3FF` | Indigo `#2B3B62` |
| Current window | Night `#0B1020` (bold) | Comet `#60D7E8` |
| Other windows | Dim `#A8B7D0` | Surface `#151F38` |
| Active pane border | Comet `#60D7E8` | Terminal default |
| Other pane borders | Indigo `#2B3B62` | Terminal default |

The theme changes styles only: mouse handling, key bindings, statusline content, and pane backgrounds remain unchanged. Pane borders respect terminal transparency; selection and the current window retain contrasting backgrounds.

### Ghostty selection vs. tmux selection

Ghostty's native selection and tmux copy-mode selection are separate. With tmux mouse capture enabled, normal dragging is handled by tmux and uses `mode-style`; it does not use Ghostty's `selection-background`.

Use Shift-drag for Ghostty's native selection. If an application also captures Shift, set this in your Ghostty configuration to reserve Shift-drag for native selection:

```ini
mouse-shift-capture = never
```

See Ghostty's [mouse-shift-capture reference](https://ghostty.org/docs/config/reference#mouse-shift-capture). This mouse preference is intentionally not part of the color theme.

## Checks

From the repository root:

```sh
vim -Nu NONE -n -i NONE -e -V1 -S tests/vim.vim
nvim --headless -u NONE -l tests/transparent.lua
ghostty +validate-config --config-file=ghostty/Kataware
```

These checks cover transparent backgrounds, retained contrast on selected rows and statuslines, and restoring opaque backgrounds after reloading the colorscheme.

The Ghostty command validates the theme configuration with your installed Ghostty version.
