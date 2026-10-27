# Kataware

A comet-lit indigo night for Vim, Neovim, Sublime Text, Yazi, Ghostty, and tmux.

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

## Sublime Text

Requires Sublime Text 4. The `sublime/` directory contains a complete UI theme, a syntax color scheme, and command-palette entries. No Python plugin, third-party theme, or extra icon package is required.

### Install

Open **Preferences → Browse Packages…** and copy the contents of `sublime/` into a directory named **Kataware** inside that Packages directory. Keep the name `Kataware`: the customization commands use it to locate the base files.

On macOS, from this repository:

```sh
packages="$HOME/Library/Application Support/Sublime Text/Packages"
mkdir -p "$packages/Kataware"
cp sublime/Kataware.sublime-* "$packages/Kataware/"
```

The usual Packages locations are:

| Platform | Directory |
| --- | --- |
| macOS | `~/Library/Application Support/Sublime Text/Packages` |
| Linux | `~/.config/sublime-text/Packages` |
| Windows | `%APPDATA%\Sublime Text\Packages` |

In the Command Palette, run both **Kataware: Apply UI Theme** and **Kataware: Apply Color Scheme**. Alternatively, merge these two entries into your user preferences:

```json
{
    "theme": "Kataware.sublime-theme",
    "color_scheme": "Kataware.sublime-color-scheme"
}
```

The UI theme and syntax scheme are separate Sublime resources; selecting only one does not activate the other. Syntax-specific or project-specific `color_scheme` settings can override the global choice.

### Coverage

| Layer | Coverage |
| --- | --- |
| Editor | Canvas, selections, inactive selections, carets, current line, line numbers, whitespace, rulers, indentation guides, bracket/tag matching, folding, minimap, search and diff markers |
| UI | Sidebar and file icons, Git status badges, tabs and dirty/preview states, status bar, command/Goto/quick panels, completion rows and kind labels, find/replace, inputs, buttons, scrollbars, progress and tooltips |
| Syntax | Semantic fallback scopes for bundled languages; web/JSX/TSX, C/C++, Rust, Go, Python, Lua, shell, SQL, JSON/YAML/TOML, regex, Markdown/rST/LaTeX, Git/diff and build/find output; targeted Odin and Zig coverage |
| Plugins | LSP semantic tokens, diagnostics, references, signature help, code actions/lenses; SublimeLinter, GitGutter, BracketHighlighter and FileBrowser scopes |
| Documentation | minihtml popup, phantom and HTML-sheet colors, including headings, links and inline code |

Functions use blue, types cyan, keywords violet, strings green, constants gold, and special forms pink. Comments use the Neovim theme's muted blue-gray. Search and selection retain quiet indigo surfaces.

The UI theme extends Sublime's built-in `Default.sublime-theme` and replaces its palette and focused states. This preserves native controls, cross-platform/HiDPI textures, file-icon integrations, and user options such as tab style, sidebar fonts, bold folder labels, overlay scrollbars and minimap visibility. It does not enable editor features or change fonts, key bindings, opacity, or plugin settings.

Coverage follows scopes supplied by each syntax or plugin; a theme cannot infer missing semantic tokens. LSP semantic highlighting must be enabled in LSP itself. Its [inlay hints use package-owned CSS](https://lsp.sublimetext.io/features/#inlay-hints), and plugins may impose their own minihtml styles. Native OS menus and file pickers remain system-controlled; title-bar styling depends on the platform. This package does not provide editor-window transparency.

### Customize

Use **Kataware: Customize UI Theme** or **Kataware: Customize Color Scheme** to open the base file beside your user override. Save changes in the **User** file, not the installed base. Sublime merges same-named resources, so your overrides survive package updates.

For example, to brighten comments without changing line numbers, add this to `Packages/User/Kataware.sublime-color-scheme`:

```json
{
    "rules": [
        {
            "scope": "comment, punctuation.definition.comment, meta.semantic-token.comment",
            "foreground": "#A8B7D0"
        }
    ]
}
```

See Sublime's [color-scheme reference](https://www.sublimetext.com/docs/color_schemes.html) and [theme reference](https://www.sublimetext.com/docs/themes.html) for other supported overrides.

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
