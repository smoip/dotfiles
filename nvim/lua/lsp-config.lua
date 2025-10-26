-- Setup completion engine
local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
  return
end

local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Setup LSP capabilities for completion
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then
  return
end
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Ensure PATH includes common binary locations for Mason
vim.env.PATH = vim.env.PATH .. ':/usr/local/bin:/opt/homebrew/bin:' .. vim.fn.expand('~/.local/bin')

-- Setup Mason
local mason_status, mason = pcall(require, 'mason')
if not mason_status then
  vim.notify("Mason not installed", vim.log.levels.WARN)
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  -- Add git configuration for better connectivity
  github = {
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },
})

-- Setup Mason-LSPConfig bridge (skip auto-install due to network issues)
local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if mason_lspconfig_status then
  mason_lspconfig.setup({
    ensure_installed = {},  -- Empty - install manually
  })
end

-- Configure language servers using new vim.lsp.config API (Neovim 0.11+)

-- TypeScript/JavaScript
vim.lsp.config.ts_ls = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  capabilities = capabilities,
}

-- Ruby/Rails
vim.lsp.config.solargraph = {
  cmd = { 'solargraph', 'stdio' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  capabilities = capabilities,
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
    }
  }
}

-- Python
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'setup.py', 'pyproject.toml', '.git' },
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
}

-- Enable the LSP servers (only if they're installed)
pcall(vim.lsp.enable, 'ts_ls')
pcall(vim.lsp.enable, 'solargraph')
pcall(vim.lsp.enable, 'pyright')

-- LSP Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    
    -- Go to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    
    -- Go to declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    
    -- Hover documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    
    -- Go to implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    
    -- Signature help (function parameters)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    
    -- Rename symbol
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    
    -- Code action (quick fixes)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Find references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Format buffer
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    
    -- Show diagnostics in floating window
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    
    -- Go to next/previous diagnostic
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end,
})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Change diagnostic symbols in the sign column
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
