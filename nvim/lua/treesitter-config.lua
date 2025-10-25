require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "typescript",
    "javascript", 
    "tsx",
    "html",
    "css",
    "python",
    "go",
    "ruby",
    "lua",
    "json",
    "yaml",
    "markdown",
    "bash",
    "fish",
  },
  
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  
  indent = {
    enable = true
  },
  
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
