# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Keymaps

Source of truth:

- LazyVim keymaps: https://www.lazyvim.org/keymaps
- Local overrides: `nvim/.config/nvim/lua/config/keymaps.lua`

Notes:

- `<leader>` is `<space>`
- `<localleader>` is `\`

### GitHub browse (custom)

These open the current file at the current line on GitHub.

- `go` browse on upstream/current branch (warns if branch is not on GitHub)
- `gO` browse on `main`
- `gC` browse on current commit (`HEAD`) (works even if branch isn't pushed)

Related built-ins from LazyVim:

- `<leader>gB` Git Browse (open)
- `<leader>gY` Git Browse (copy URL)

### Handy LazyVim defaults (cheatsheet)

Common navigation:

- `<C-h>/<C-j>/<C-k>/<C-l>` move between windows
- `<S-h>/<S-l>` previous/next buffer
- `[b` / `]b` previous/next buffer
- `<esc>` clear search highlight

Find/search (Snacks picker):

- `<leader><space>` find files (root)
- `<leader>ff` find files (root)
- `<leader>fg` find git files
- `<leader>/` grep (root)
- `<leader>,` buffers

Terminal:

- `<c-/>` terminal (root)
- `<leader>ft` terminal (root)
- `<leader>fT` terminal (cwd)

LSP essentials:

- `gd` go to definition
- `gr` references
- `gI` go to implementation
- `gy` go to type definition
- `K` hover
- `<leader>ca` code action
- `<leader>cr` rename

Diagnostics:

- `<leader>cd` line diagnostics
- `]d` / `[d` next/prev diagnostic
- `]e` / `[e` next/prev error
- `]w` / `[w` next/prev warning

Buffers/tabs:

- `<leader>bd` delete buffer
- `<leader>bo` delete other buffers
- `<leader><tab><tab>` new tab
- `<leader><tab>]` / `<leader><tab>[` next/prev tab

Git (Snacks):

- `<leader>gs` git status
- `<leader>gb` git blame line
- `<leader>gl` git log (repo)
- `<leader>gf` git file history
