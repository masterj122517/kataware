# Kataware

A comet-lit indigo night for Neovim, Yazi, and Ghostty.

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

Ghostty controls terminal transparency separately from color themes:

```ini
background-opacity = 0.8
background-blur = 32
```
