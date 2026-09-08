vim.g.mapleader = " "
vim.cmd([[so ~/.config/nvim/legacy.vim]])
vim.g.python3_host_prog = '/usr/bin/python3'

require("plugins")
require('mylsp')
require('nvimcmp')


vim.keymap.set("n", "<M-o>", "<C-o>") -- 用 Alt-i 和 Alt-o 來代替，避免跟 Tab 衝突
vim.keymap.set("n", "<M-i>", "<C-i>")
vim.keymap.set("n", "<leader>=", "glip=", { remap = true, })
vim.keymap.set("n", "<leader>'", function() vim.fn.system("tmux split-window -v -p 25") end)
vim.keymap.set("n", "<leader>;", function() vim.fn.system("tmux kill-pane -t :.bottom") end, { silent = true })
vim.keymap.set("n", "<leader>c", function() vim.fn.system("tmux new-window") end)


vim.lsp.log.set_level("OFF") -- turn off lsp.log at ~/.local/state/nvim/lsp.log


vim.api.nvim_set_hl(0, "annotation", { fg = "#ebdbb2", })
vim.fn.matchadd("annotation", [[\<NOTE\>]])
vim.fn.matchadd("annotation", [[\<TODO\>]])
vim.fn.matchadd("annotation", [[\<FIXME\>]])
vim.fn.matchadd("annotation", [[\<BUG\>]])


vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})


require('render-markdown').setup({ completions = { lsp = { enabled = true } },})
vim.api.nvim_set_keymap('n', ';md', ':RenderMarkdown toggle<CR>', { noremap = true, silent = true })


require("ipynb").setup()


require("nvim-tree").setup()
vim.keymap.set("n", ";t", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", ";f", "<cmd>NvimTreeFindFile<CR>")


require("gruvbox").setup({
  invert_selection = true,
  transparent_mode = false,
  contrast = "hard", -- hard/soft/""
  inverse = false, -- invert background for search, diffs, statuslines and errors
  overrides = {
    ["RenderMarkdownCode"] = { bg = "#282828", },

    ["Pmenu"] = { bg = "#5a5a5a", }, -- 補全背景
    ["NormalFloat"] = { bg = "#5a5a5a", }, -- Shift + K 後的背景

    -- nvim-cmp UI
    ["CmpItemKindVariable"] = { fg = "#fabd2f", },
    ["CmpItemKindSnippet"]  = { fg = "#fabd2f", bg = "#665c54", },
    ["CmpItemAbbr"]         = { fg = "#ebdbb2", },
    ["CmpItemKindFunction"] = { fg = "#b8bb26", }, -- #b8bb26 or #fabd2f
    ["CmpItemKindKeyword"]  = { fg = "#fabd2f", },
    ["CmpItemKindText"]     = { fg = "#fabd2f", },
    ["CmpItemKind"]         = { fg = "#83a598", bg = "#3c3836", },


    -- py
    ["@variable.python"]         = { fg = "#8fad8a" }, -- #83a598 or #8fad8a
    ["@module.python"]           = { fg = "#83a598" }, -- #8fad8a or #458588
    ["@function.builtin.python"] = { fg = "#b8bb26" },
    ["@operator.python"]         = { fg = "#ebdbb2" }, -- white
    ["@string.prefix.python"]    = { fg = "#ec6a65" }, -- red
    ["@constructor.python"]      = { fg = "#fabd2f" }, -- yellow

    -- c
    -- ["@property.c"]      = { fg = "#458588" }, -- struct members (suite for large project)
    -- ["@variable.c"]      = { fg = "#458588" },
    ["@variable.c"]         = { fg = "#83a598" }, -- #83a598 or #8fad8a
    ["@keyword.modifier.c"] = { fg = "#fe8019" }, -- GruvboxOrange
    ["@operator.c"]         = { fg = "#ebdbb2" }, -- GruvboxFg
    ["@constant.macro.c"]   = { fg = "#d3869b" }, -- GruvboxPurple

    -- cpp
    ["@module.cpp"]           = { fg   = "#83a598" },
    ["@constant.macro.cpp"]   = { fg   = "#d3869b" }, -- GruvboxPurple
    -- ["@variable.cpp"]      = { fg   = "#458588" },
    ["@variable.cpp"]         = { fg   = "#83a598" }, -- #8f9e8d LGTM, but not work
    ["@operator.cpp"]         = { fg   = "#ebdbb2" }, -- GruvboxFg
    ["@keyword.modifier.cpp"] = { fg   = "#fe8019" }, -- Orange(#fe8019) or Yellow(#fabd2f)
    ["@namespace.cpp"]        = { link = "GruvboxAqua" }, -- GruvboxFg
  },
  palette_overrides = {
    bright_aqua = "#8fad8a",
    bright_red = "#ec6a65",
    gray = "#808080",
    bright_purple = "#cc8bad",
    dark1 = "#434343", -- signcolumn ; #3a3a3a/#434343
    dark4 = "#7d7d7d", -- line number
    dark5 = "#808080",
  }
})
vim.o.background = "dark" -- Gruvbox hard: Brightness = -1, Contrast = +2
vim.cmd.colorscheme("gruvbox")


require('nvim-web-devicons').setup()

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    }
  },
  options = {
    theme = {
      normal = {
        a = { fg = "#282828", bg = "#ae9393" },
        b = { fg = "#ebdbb2", bg = "#504945" },
        c = { fg = "#a89984", bg = "#434343" },
      },
      insert = {
        b = { fg = "#ebdbb2", bg = "#504945" },
        c = { fg = "#a89984", bg = "#434343" },
      },
      command = {
        b = { fg = "#ebdbb2", bg = "#504945" },
        c = { fg = "#a89984", bg = "#434343" },
      },
      visual = {
        b = { fg = "#ebdbb2", bg = "#504945" },
        c = { fg = "#a89984", bg = "#434343" },
      },
    },
    -- minimal+
    section_separators   = { left = "", right  = "", },
    component_separators = { left = "│", right = "│", },

    -- minimal
    -- section_separators = '',
    -- component_separators = '',

    -- rounded corners
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
  },
})


local fzf = require("fzf-lua")
local actions = require ("fzf-lua.actions")
vim.keymap.set("n", "<C-p>", function() fzf.files() end)
vim.keymap.set("n", "<leader>p", function() fzf.files({ fd_opts = "--type f --type l --hidden --no-ignore", }) end)
vim.keymap.set("n", "<C-g>", function() fzf.grep() end)
vim.keymap.set("n", "<leader>g", function() fzf.grep({ fd_opts = "--type f --type l --hidden --no-ignore", }) end)
vim.keymap.set("n", ";b", function() fzf.buffers() end)
vim.keymap.set("n", ";gc", function() fzf.git_commits({ no_ignore = true }) end)
vim.keymap.set("n", ";gs", function() fzf.git_status({ no_ignore = true }) end)
vim.keymap.set("n", ";gb", function() fzf.git_branches({ no_ignore = true }) end)
vim.keymap.set("n", ";gf", function() fzf.git_diff({ no_ignore = true }) end)

require("fzf-lua").setup{
  actions = {
    files = {
      ["enter"]  = actions.file_edit_or_qf,
      ["ctrl-x"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["alt-q"]  = actions.file_sel_to_qf,
      ["alt-Q"]  = actions.file_sel_to_ll,
    },
  },
  fzf_opts = {
    ["--ansi"]           = true,
    ["--info"]           = "inline-right", -- inline/inline-right
    ["--height"]         = "100%",
    ["--layout"]         = "default",
    ["--border"]         = "none",
    ["--highlight-line"] = true,
    ["--pointer"]        = "▶",
    -- fzf_tmux_opts = { ["-p"] = "80%,80%", ["--margin"] = "0,0" },
  },
  winopts = {
    border = "thicc", -- preview border: accepts both `nvim_open_win`
    preview = {
      border    = "thicc", -- preview border: accepts both `nvim_open_win`
      vertical  = 'up:60%', -- 將 preview 顯示在上面
      title_pos = "left", -- left|center|right, title alignment
    },
  },
  files = {
    fd_opts = " --type f --type l --hidden --exclude .git --exclude .venv --exclude __pycache__",
    -- rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!.venv'",
  },
  previewers = {
    bat = {
      cmd  = "bat",
      args = "--color=always --style=numbers,changes",
    },
    builtin = {
      title_fnamemodify = function(path) return vim.fn.fnamemodify(path, ":.") end,
    },
  },
}


-- change variable name
vim.keymap.set("n", "<leader>g", function() require("spectre").open() end)
vim.keymap.set("n", "<leader>k", function() require("spectre.actions").run_replace() end)
vim.keymap.set("n", "<leader>l", function() vim.cmd("normal! viw") require("spectre").open_file_search() end)
require('spectre').setup({ live_update = true, })


require "lsp_signature".setup({
  floating_window = false,
  bind = true,
  hint_prefix = "🔎 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
})


-- from :h lsp-semantic-highlight. Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end


require("aerial").setup()
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")


require("mason").setup()

