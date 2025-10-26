# Custom bindings etc.

## TELESCOPE
- `<C-p>` - Find files (maintained old mapping)
- `<leader>fg` - Live grep (needs ripgrep)
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

## TREESITTER SELECTION
- `gnn` - Init selection (current word)
- `grn` - Expand selection (syntax node)
- `grm` - Shrink selection
- `grc` - Expand selection to scope boundary

## COMMENTING (vim-commentary)
- `gcc` - Toggle comment on line
- `gc{motion}` - Comment motion (gcap = comment paragraph)
- `gc` (visual) - Comment selection

## TMUX
- `<prefix> h/j/k/l` - Navigate panes
- `<prefix> v` - Split vertical
- `<prefix> s` - Split horizontal
- `<prefix> r` - Reload config

## MASON (LSP Manager)
- `:Mason` - Open language server manager
- `:MasonUpdate` - Update all servers

## LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `K` - Hover documentation
- `gi` - Go to implementation
- `gr` - Find references
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions (quick fixes)
- `<leader>f` - Format buffer
- `<leader>e` - Show error details
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## COMPLETION (Insert Mode)
- `<C-Space>` - Trigger completion
- `<Tab>` / `<S-Tab>` - Navigate completion items
- `<CR>` - Confirm selection
- `<C-e>` - Abort completion
