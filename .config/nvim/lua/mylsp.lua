-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', ',e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gE', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', ',q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- local dap = require("dap")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- OLD
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'                           -- NEW

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', ',s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts) 	-- 註：可一鍵更改所有變數！
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  -- python debugging mappings
  -- vim.api.nvim_set_keymap('n', ';db', '<cmd>DapToggleBreakpoint<CR>', opts)
  -- vim.api.nvim_set_keymap('n', ';dtm', '<cmd>lua require("dap-python").test_method()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', ';t', '<cmd>lua require("dapui").toggle()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', ';c', '<cmd>lua require("dapui").close()<CR>', opts)
  -- vim.keymap.set('n', ';dc', dap.continue, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Adds smart features to editor,
-- code completion, compile errors, go-to-definition and more.
vim.lsp.config('clangd', {
    on_attach = on_attach,
    cmd = {
      '/opt/homebrew/opt/llvm/bin/clangd',
      '--background-index',
      '--pch-storage=memory',
      '--all-scopes-completion',
      '--pretty',
      '--header-insertion=never',
      '-j=4',
      '--header-insertion-decorators',
      '--function-arg-placeholders',
      '--completion-style=detailed',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { 'src' },
    capabilities = capabilities,
})
-- touch .clangd on workspace dir to avoid annoying errors form clangd:
-- CompileFlags: 
--   Add: [ "-std=c++20" ]  # 添加 C++20 標準的編譯選項
--   Compiler: "clang++"    # 使用 clang++ 作為編譯器


vim.lsp.config('pyright', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      '/Users/dah/.local/share/nvim/mason/bin/pyright-langserver',
      '--stdio',
    },
})


vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
            workspace = {
                -- 讓 lua_ls 去讀取 Neovim 內建的 runtime 檔案，這樣打 vim. 才會跳出補全
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- 關閉煩人的第三方套件提示
            },
		},
	},
})

vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls' })

-- vim.diagnostic.config({ virtual_text = true, })

local diagnostic_signs = {
	Error = "\u{f057} ",
	Warn  = "\u{f071} ",
	Hint  = "\u{ea61}",
	Info  = "\u{f05a}",
}

vim.diagnostic.config({
	-- virtual_text = { prefix = "●", spacing = 4 },
	virtual_text = { virtual_text = true, },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float)

