# Kataware

A comet-lit indigo night for Vim, Neovim, Sublime Text, Yazi, Ghostty, tmux, ripgrep, and fzf.

## Palette balance

The themes share the palette of [kataware.nvim](https://github.com/masterj122517/kataware.nvim). The goal is one visual hierarchy, not an identical amount of color in every application:

| Role | Color | Usage |
| --- | --- | --- |
| Canvas | `#0B1020` | Terminal and opaque editor backgrounds |
| Text | `#D9E2F2` | Default foreground |
| Quiet chrome | `#10172A` | tmux status row and inactive tabs |
| Floating surface | `#151F38` | Editor floats and tmux messages |
| Selection surface | `#1D2A49` | Neovim Visual, Ghostty selection, tmux copy mode and current tab |
| Structural border | `#2B3B62` | Inactive pane edges |
| Muted detail | `#6B7FA2` | Editor line numbers, inactive tmux labels and active pane edge |
| Focus text | `#60D7E8` | Current tmux window label |
| Cursor and selected text | `#EEF3FF` | Ghostty cursor and terminal selection foreground |

All 16 ANSI colors match Neovim's terminal palette. Syntax, diagnostics, shell output and terminal tools keep the existing indigo/spectral colors. Focus uses small accents on quiet surfaces instead of large cyan or violet blocks.

## Pairing with Vim and Neovim

Vim and Neovim themes are installed separately; this repository no longer contains the `colors/` adapters. Use [kataware.nvim](https://github.com/masterj122517/kataware.nvim) for Neovim, including both its `colors/kataware.lua` entrypoint and `lua/kataware/` modules when installing manually.

When using the matching editor theme:

```lua
-- Neovim: let the terminal canvas show through.
vim.g.kataware_transparent = true
vim.cmd.colorscheme 'kataware'
```

```vim
" Vim: use your separately installed Kataware Vimscript theme.
let g:kataware_transparent = 1
colorscheme kataware
```

Opaque editors use the shared canvas directly. Transparent editors inherit the terminal's composited background, so wallpaper and Ghostty opacity still affect perceived contrast. Opacity belongs to the terminal configuration and is not forced by this theme.

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

Native text selection uses the same `#1D2A49` surface as Neovim's Visual highlight, with `#EEF3FF` selected text. The cursor is also `#EEF3FF`, matching Neovim's cursor. The tmux theme below shares the selection colors.

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
| Copy-mode selection | Starlight `#EEF3FF` | Selection surface `#1D2A49` |
| Current window | Comet `#60D7E8` (bold) | Selection surface `#1D2A49` |
| Other windows | Muted `#6B7FA2` | Night `#10172A` |
| Active pane border | Muted `#6B7FA2` | Terminal default |
| Other pane borders | Indigo `#2B3B62` | Terminal default |

The theme changes styles only: mouse handling, key bindings, statusline content, and pane backgrounds remain unchanged. Pane borders respect terminal transparency. The current window is distinguished by cyan text and a subtle background rather than an inverted cyan block.

### Ghostty selection vs. tmux selection

Ghostty's native selection and tmux copy-mode selection are separate. With tmux mouse capture enabled, normal dragging is handled by tmux and uses `mode-style`; it does not use Ghostty's `selection-background`.

Use Shift-drag for Ghostty's native selection. If an application also captures Shift, set this in your Ghostty configuration to reserve Shift-drag for native selection:

```ini
mouse-shift-capture = never
```

See Ghostty's [mouse-shift-capture reference](https://ghostty.org/docs/config/reference#mouse-shift-capture). This mouse preference is intentionally not part of the color theme.

## ripgrep

`ripgrep/kataware.conf` contains colors only: blue paths, muted line/column numbers, and bold gold matches. It leaves search rules, output format, and automatic color detection unchanged. Piped output stays plain unless you request `--color=always`.

For a new configuration:

```sh
mkdir -p ~/.config/ripgrep
cp ripgrep/kataware.conf ~/.config/ripgrep/kataware.conf
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/kataware.conf"
```

Add the export to your shell startup file. If you already use a ripgrep configuration, keep `RIPGREP_CONFIG_PATH` pointing to it and replace its `--colors` entries with the contents of `ripgrep/kataware.conf`. ripgrep reads one configuration file; it does not source a separate theme file.

## fzf

`fzf/kataware.fzf` contains color options only. The canvas and preview inherit the terminal background, preserving transparency. The current row uses the shared `#1D2A49` selection surface; marked rows use `#151F38`. Cyan identifies the prompt and pointer, violet marks selections, and gold highlights matches. Borders and both list/preview scrollbars use structural indigo (`#2B3B62`), not foreground or line-number colors. The preview scrollbar is set explicitly so its color does not depend on preview-border inheritance.

The left-hand list gutter (`▌`) follows the current-row background (`bg+`), as in [Catppuccin's fzf theme](https://github.com/catppuccin/fzf). Do not set `gutter:-1`: fzf also uses this role as the glyph's foreground, so `-1` produces a terminal-default foreground stripe rather than a transparent gutter.

Install and add the export to your shell startup file:

```sh
mkdir -p ~/.config/fzf
cp fzf/kataware.fzf ~/.config/fzf/kataware.fzf
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/kataware.fzf"
```

Keep key bindings, layout, preview commands, and other behavior in `FZF_DEFAULT_OPTS`. Remove old `--color` options from that variable: it overrides `FZF_DEFAULT_OPTS_FILE`, and command-line options override both. If you already use an options file, merge these color lines into it instead.

The theme uses `FZF_DEFAULT_OPTS_FILE` and section/selection color roles; verified with fzf 0.74.4. Preview programs such as bat retain their own syntax colors. With `fzf --ansi`, colored ripgrep input also retains its source colors outside fzf's match highlights.

## Checks

From the repository root:

```sh
ghostty +validate-config --config-file=ghostty/Kataware
ghostty +show-config
```

`validate-config` checks the theme with your installed Ghostty version. After installing, `show-config` reports the effective configuration, including theme colors and independently configured opacity. Reload Ghostty's configuration to apply theme edits to existing windows.

The tmux theme can be loaded in a running server with the `source-file` command above; inspect the effective styles with:

```sh
tmux show-options -g mode-style
tmux show-options -g window-status-current-style
tmux show-options -g pane-active-border-style
```
