-- - Lazy plugin manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  -- general plugins
  'mg979/vim-visual-multi',
  'nvim-lua/plenary.nvim', -- telescope & typescript dep
  'nvim-telescope/telescope.nvim', -- fuzzy finder
  'nvim-tree/nvim-web-devicons', -- lualine dep
  'nvim-lualine/lualine.nvim', -- status bar
  'kylechui/nvim-surround',
  'windwp/nvim-autopairs',
  'RRethy/vim-illuminate',
  -- 'lewis6991/gitsigns.nvim',
  'mhartington/formatter.nvim',
  'cappyzawa/trim.nvim',
  -- 'github/copilot.vim',
  -- 'RRethy/nvim-treesitter-endwise',

  {
      'folke/zen-mode.nvim',
      opts = {
          window = {
              width = 82,
          }
      }
  },

  'nvim-tree/nvim-tree.lua', -- file explorer
  'stevearc/aerial.nvim',

  -- 'MunifTanjim/nui.nvim', -- neo-tree dep
  -- 's1n7ax/nvim-window-picker', -- neo-tree window picker dep
  -- 'mrbjarksen/neo-tree-diagnostics.nvim', -- neo-tree diagnostics
  -- 'nvim-neo-tree/neo-tree.nvim', -- file explorer
  'akinsho/toggleterm.nvim', -- floating terminal

  -- odin
  'DanielGavin/ols',

  -- c3
  'ManuLinares/nvim-c3',

  -- completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/nvim-cmp',

  -- colorschemes
  'RRethy/base16-nvim',
})

--- Plugin settings

vim.g.VM_case_setting = 'sensitive'

-- Languages

require("c3").setup()

vim.lsp.config('ols', {
    cmd = { 'ols' },
    filetypes = { 'odin' },
    root_markers = { '.git', 'ols.json' },
})
vim.lsp.enable('ols')

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        'compile_commands.json',
        'compile_flags.txt',
        '.git',
    },
})
vim.lsp.enable('clangd')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.diagnostic.config({ virtual_text = false })

require("nvim-tree").setup({
  -- sort = {
  --   sorter = "case_sensitive",
  -- },
  view = {
    width = 26,
  },
  diagnostics = {
    enable = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = 'after',
      show = {
        file = false,
        folder = false,
        -- folder_arrow = false,
        -- git = false,
        -- modified = false,
        diagnostics = true,
        -- bookmarks = false,
      }
    }
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    no_bookmark = false,
  },
})

require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'base16',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {'searchcount', 'diagnostics'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'filename'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'lsp_status'}
  }
})

-- require("window-picker").setup({
--   selection_chars = 'ABCDEF1234567890JKHL',
--   filter_rules = {
--     include_current_win = false,
--     autoselect_one = true,
--     -- filter using buffer options
--     bo = {
--       -- if the file type is one of following, the window will be ignored
--       filetype = { "neo-tree", "neo-tree-popup", "notify" },
--       -- if the buffer type is one of following, the window will be ignored
--       buftype = { "terminal", "quickfix" },
--     },
--   },
--   highlights = {
--     enabled = true,
--   },
-- })
--
-- require('neo-tree').setup({
--   window = {
--     width = 32,
--     mappings = {
--         ['o'] = 'open_with_window_picker',
--         ['l'] = 'open_with_window_picker',
--         ['h'] = 'toggle_node',
--     },
--   },
--   sources = {
--     'filesystem',
--     'buffers',
--     'git_status',
--     'document_symbols',
--     'diagnostics',
--   },
--   renderers = {
--     file = {
--       -- { "indent" },
--       -- { "icon" }, -- Comment out or delete this line to remove the icon
--       { "name", use_filtered_colors = true },
--       { "diagnostics" },
--       { "git_status" },
--     },
--   },
--   filesystem = {
--     follow_current_file = {
--       enabled = true,
--     }
--   },
--   default_component_configs = {
--     git_status = {
--       symbols = {
--         -- Change type
--         added     = "",
--         deleted   = "",
--         modified  = "",
--         renamed   = "",
--         -- Status type
--         untracked = "",
--         ignored   = "",
--         unstaged  = "",
--         staged    = "",
--         conflict  = "",
--       },
--     },
--   },
-- })

require('nvim-surround').setup({})

require('illuminate').configure({
  providers = {
    'regex',
  },
  min_count_to_highlight = 4,
  large_file_cutoff = 2000,
})

-- require('gitsigns').setup()

require("toggleterm").setup({
    direction = "float",
    open_mapping = [[<c-\>]],
})


local function limitByFileSize(lang, buf)
  local max_filesize = 100 * 1024 -- 100Kb
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

-- Fix Ruby indentation bug
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'ruby',
--   command = 'setlocal indentkeys-=.',
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = 'qf', -- QuickFix and Location Lists
  callback = function()
    -- Map Enter in this buffer only, using '<CR>' to trigger the default jump
    vim.keymap.set('n', '<CR>', '<CR>', { buffer = true, remap = false })
  end,
})

require("nvim-autopairs").setup({})

local util = require 'formatter.util'
require("formatter").setup({
   filetype = {
    -- lua = {
    --   function()
    --     return {
    --       exe = "lua-format",
    --       args = {
    --         '--indent-width 2',
    --         '--tab-width 2',
    --         util.escape_path(util.get_current_buffer_file_path()),
    --       },
    --       stdin = true
    --     }
    --   end
    -- },
    javascript = { require('formatter.defaults.prettier') },
    javascriptreact = { require('formatter.defaults.prettier') },
    typescript = { require('formatter.defaults.prettier') },
    typescriptreact = { require('formatter.defaults.prettier') },
    css = { require('formatter.defaults.prettier') },
    scss = { require('formatter.defaults.prettier') },
    json = { require('formatter.defaults.prettier') },
    ruby = { require('formatter.filetypes.ruby').rubocop },
    rust = { require('formatter.filetypes.rust').rustfmt },
    go = { require('formatter.filetypes.go').gofmt },
    c = { require('formatter.defaults.clangformat') },
    cpp = { require('formatter.defaults.clangformat') },
    glsl = { require('formatter.defaults.clangformat') },
    odin = {
      function()
        return {
          exe = "odinfmt",
          args = {
            "-stdin",
          },
          stdin = true,
        }
      end
    },
    crystal = {
      function()
        return {
          exe = "crystal",
          args = {
            "tool",
            "format",
            "--no-color",
            "-",
          },
          stdin = true,
        }
      end
    },
    gdscript = {
      function()
        return {
          exe = "gdformat",
          args = {
            "--use-spaces=4",
            "--line-length=300",
          },
        }
      end
    },
    -- ["*"] = {
    --   require("formatter.filetypes.any").remove_trailing_whitespace
    -- }
  }
})

require('trim').setup({})

vim.g.copilot_node_command = '/opt/homebrew/bin/node'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.complete(),
    ['<C-q>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

--- Neovide options

if vim.g.neovide then
    -- Allow clipboard copy paste in neovim
    vim.g.neovide_input_use_logo = 1
    vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
end

--- Settings

vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.lazyredraw = true
vim.opt.virtualedit = 'all'
vim.opt.undofile = true
vim.opt.signcolumn = 'yes' -- 'auto:1-2'
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '▸ ' }
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = '#region,#endregion'

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = '80'

vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 0

vim.opt.undodir = vim.env.HOME .. '/.vim/undodir/'
vim.opt.backupdir = vim.env.HOME .. '/.vim/backup/'
vim.opt.directory = vim.env.HOME .. '/.vim/backup/'

vim.opt.background = "dark"

vim.opt.shell = '/bin/zsh'

vim.cmd.colorscheme 'base16-catppuccin-mocha'
-- vim.cmd.colorscheme 'base16-gruvbox-material-dark-hard'
-- vim.cmd.colorscheme 'base16-gruvbox-material-dark-soft'

--- Keybindings

vim.g.mapleader = ' '

local remap = { noremap = false }
local noremap = { noremap = true }
local noremap_silent = { noremap = true, silent = true }

-- movements
vim.api.nvim_set_keymap('n', 'j', 'gj', noremap)
vim.api.nvim_set_keymap('n', 'k', 'gk', noremap)
vim.api.nvim_set_keymap('n', 'J', ":call search('\\%' . virtcol('.') . 'v\\S', 'W')<CR>", noremap_silent)
vim.api.nvim_set_keymap('n', 'K', ":call search('\\%' . virtcol('.') . 'v\\S', 'bW')<CR>", noremap_silent)
vim.api.nvim_set_keymap('n', 'H', '^', noremap)
vim.api.nvim_set_keymap('n', 'L', 'g_', noremap)
vim.api.nvim_set_keymap('v', 'j', 'gj', noremap)
vim.api.nvim_set_keymap('v', 'k', 'gk', noremap)
vim.api.nvim_set_keymap('v', 'H', '^', noremap)
vim.api.nvim_set_keymap('v', 'L', 'g_', noremap)

vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', noremap)
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', noremap)

vim.api.nvim_set_keymap('n', 'U', '<C-r>', noremap) -- redo
vim.api.nvim_set_keymap('n', 'Y', 'y$', noremap) -- copy line

vim.api.nvim_set_keymap('n', '+', '<C-a>', noremap) -- increase a number
vim.api.nvim_set_keymap('n', '-', '<C-x>', noremap) -- decrease a number

vim.api.nvim_set_keymap('n', '<CR>', ':', noremap)
vim.api.nvim_set_keymap('n', '<Tab>', ':w<CR>', noremap)
vim.api.nvim_set_keymap('n', '=', ':set invcursorline<CR>:set invcursorcolumn<CR>', noremap_silent)

-- switch to previous buffer
vim.api.nvim_set_keymap('n', '<BS>', '<C-^>', noremap_silent)

-- pane switch
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', noremap)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', noremap)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', noremap)
vim.api.nvim_set_keymap('n', '<Leader>h', '<C-w>h', noremap)
vim.api.nvim_set_keymap('n', '<Leader>j', '<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<Leader>k', '<C-w>k', noremap)
vim.api.nvim_set_keymap('n', '<Leader>l', '<C-w>l', noremap)
-- pane split
vim.api.nvim_set_keymap('n', '<C-w>h', '<C-w>v', noremap)
vim.api.nvim_set_keymap('n', '<C-w>j', '<C-w>s<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<C-w>k', '<C-w>s', noremap)
vim.api.nvim_set_keymap('n', '<C-w>l', '<C-w>v<C-w>l', noremap)
vim.api.nvim_set_keymap('n', '<Leader>H', '<C-w>v', noremap)
vim.api.nvim_set_keymap('n', '<Leader>J', '<C-w>s<C-w>j', noremap)
vim.api.nvim_set_keymap('n', '<Leader>K', '<C-w>s', noremap)
vim.api.nvim_set_keymap('n', '<Leader>L', '<C-w>v<C-w>l', noremap)

-- leader fns
vim.api.nvim_set_keymap('n', '<Leader>f', ':Format<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>z', 'gcc', remap) -- toggle comment
vim.api.nvim_set_keymap('v', '<Leader>z', 'gc', remap) -- toggle comment
-- vim.api.nvim_set_keymap('n', '<Leader>gb', ':Gitsigns blame_line<CR>', noremap)

-- switch tab size
vim.api.nvim_set_keymap('n', '<Leader>t2', ':set ts=2 sw=2 sts=2<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>t4', ':set ts=4 sw=4 sts=4<CR>', noremap)

-- show current file in nvim-tree explorer
vim.api.nvim_set_keymap('n', '<C-o>', ':NvimTreeFindFile<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>o', ':AerialToggle!<CR>', noremap)

-- neo-tree explorer
-- vim.api.nvim_set_keymap('n', '<C-o>', ':Neotree reveal focus<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<C-b>', ':Neotree action=show toggle=true<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>o', ':Neotree toggle<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>1', ':Neotree filesystem<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>2', ':Neotree document_symbols<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>3', ':Neotree diagnostics<CR>', noremap)

-- telescope fuzzy search
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-g>', ':Telescope live_grep<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope grep_string<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>gf', ':Telescope lsp_document_symbols<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>p', ':Telescope lsp_dynamic_workspace_symbols<CR>', noremap)

-- hover float
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':lua vim.lsp.buf.hover()<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua vim.diagnostic.open_float(0, { scope = "line" })<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>gd', ':lua vim.diagnostic.jump({ count = 1, float = true })<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>gD', ':lua vim.diagnostic.jump({ count = -1, float = true })<CR>', noremap)

-- typescript lsp
-- vim.api.nvim_set_keymap('n', '<Leader>tg', ':TSToolsGoToSourceDefinition<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>ti', ':TSToolsAddMissingImports<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>tc', ':TSToolsOrganizeImports<CR>', noremap)

-- insert mode
---- movements
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', remap)
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', remap)
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', remap)
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', remap)
---- autocomplete on tab
vim.api.nvim_set_keymap('i', '<Tab>', '<C-n>', remap)
-- vim.api.nvim_set_keymap('i', '<S-Tab>', '<Tab>', noremap)

-- visual mode
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', noremap)
vim.api.nvim_set_keymap('v', '<Leader>s', ':sort<CR>', noremap)
vim.api.nvim_set_keymap('v', '<Leader>.', ':normal .<CR>', noremap)
vim.api.nvim_set_keymap('v', '<', '<gv', noremap)
vim.api.nvim_set_keymap('v', '>', '>gv', noremap)
vim.api.nvim_set_keymap('v', 's', 'S', remap)

-- run task
vim.api.nvim_set_keymap('n', '<C-r>', ':!task<CR>', noremap)

--- Iterate colorschemes
-- local colorschemes = vim.fn.getcompletion("", "color")
-- local colorschemes_idx = vim.fn.index(colorschemes, vim.api.nvim_cmd({ cmd = "colorscheme" }, { output = true }))
--
-- local function change_colorscheme(forward)
--     if forward then
--         colorschemes_idx = colorschemes_idx + 1
--     else
--         colorschemes_idx = colorschemes_idx - 1
--     end
--
--     if colorschemes_idx > #colorschemes then
--         colorschemes_idx = 1
--     elseif colorschemes_idx < 1 then
--         colorschemes_idx = #colorschemes
--     end
--
--     local ok = pcall(function()
--         vim.cmd("colorscheme " .. colorschemes[colorschemes_idx])
--     end)
--
--     if not ok then
--         change_colorscheme(forward)
--     end
--
--     print(colorschemes[colorschemes_idx])
-- end
--
-- vim.keymap.set("n", "<C-x>", function()
--     change_colorscheme(true)
-- end)
--
-- vim.keymap.set("n", "<C-z>", function()
--     change_colorscheme(false)
-- end)
