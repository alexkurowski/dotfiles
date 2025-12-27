--- Lazy plugin manager

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
  -- odin
  'DanielGavin/ols',

  -- typescript
  'pmizio/typescript-tools.nvim',

  -- crystal
  -- 'vim-crystal/vim-crystal',
  -- 'jlcrochet/vim-crystal',

  -- general plugins
  'mg979/vim-visual-multi',
  'nvim-lua/plenary.nvim', -- telescope & typescript dep
  'nvim-telescope/telescope.nvim',
  'kylechui/nvim-surround',
  'windwp/nvim-autopairs',
  'RRethy/vim-illuminate',
  'lewis6991/gitsigns.nvim',
  'neovim/nvim-lspconfig',
  'mhartington/formatter.nvim',
  'cappyzawa/trim.nvim',
  'github/copilot.vim',
  'nvim-treesitter/nvim-treesitter',
  'RRethy/nvim-treesitter-endwise',
  'nvim-tree/nvim-tree.lua', -- file explorer
  'chentoast/marks.nvim',

  -- colorschemes
  'RRethy/base16-nvim',
})

--- Plugin settings

vim.g.VM_case_setting = 'sensitive'

vim.lsp.enable('ols')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
  -- sort = {
  --   sorter = "case_sensitive",
  -- },
  view = {
    width = 40,
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
        -- diagnostics = false,
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

require('nvim-surround').setup({})

require('illuminate').configure({
  providers = {
    'regex',
  },
  min_count_to_highlight = 4,
  large_file_cutoff = 2000,
})

require('gitsigns').setup()

require("typescript-tools").setup({})

local function limitByFileSize(lang, buf)
  local max_filesize = 100 * 1024 -- 100Kb
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'ruby',
    'javascript',
    'typescript',
    'lua',
    'go',
  },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    disable = limitByFileSize,
  },
  indent = {
    enable = true,
    disable = limitByFileSize,
  },
  endwise = {
    enable = true,
    disable = limitByFileSize,
  },
})

-- Fix Ruby indentation bug
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby',
  command = 'setlocal indentkeys-=.',
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

vim.g.copilot_node_command = '/Users/mapi/.nvm/versions/node/v24.11.1/bin/node'

require('marks').setup({})
vim.api.nvim_create_autocmd("VimEnter", {
  -- Disable marks signs by default
  callback = function()
    vim.cmd("MarksToggleSigns")
  end,
})

--- Settings

vim.opt.ruler = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.lazyredraw = true
vim.opt.virtualedit = 'all'
vim.opt.undofile = true
vim.opt.signcolumn = 'yes' -- 'auto:1-2'
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '▸ ' }
vim.opt.cursorcolumn = false
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = '100'

vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 0

vim.opt.undodir = vim.env.HOME .. '/.vim/undodir/'
vim.opt.backupdir = vim.env.HOME .. '/.vim/backup/'
vim.opt.directory = vim.env.HOME .. '/.vim/backup/'

vim.opt.background = "dark"

vim.opt.shell = '/bin/bash'

-- vim.cmd.colorscheme 'base16-da-one-ocean'
vim.cmd.colorscheme 'base16-gruvbox-material-dark-hard'

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

vim.api.nvim_set_keymap('n', 'U', '<C-r>', noremap)
vim.api.nvim_set_keymap('n', 'Y', 'y$', noremap)

-- increase/decrease a number
vim.api.nvim_set_keymap('n', '+', '<C-a>', noremap)
vim.api.nvim_set_keymap('n', '-', '<C-x>', noremap)

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

-- bookmarks fns
vim.api.nvim_set_keymap('n', 'mm', ':MarksToggleSigns<CR>', noremap)

-- leader fns
vim.api.nvim_set_keymap('n', '<Leader>f', ':Format<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><Leader>', '<C-v>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Gitsigns blame_line<CR>', noremap)
-- vim.api.nvim_set_keymap('n', '<Leader>t', ':terminal<CR>', noremap)

-- switch tab size
vim.api.nvim_set_keymap('n', '<Leader>t2', ':set ts=2 sw=2 sts=2<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>t4', ':set ts=4 sw=4 sts=4<CR>', noremap)

-- show current file in nvim-tree explorer
vim.api.nvim_set_keymap('n', '<C-o>', ':NvimTreeFindFile<CR>', noremap)

-- telescope fuzzy search
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>g', ':lua require("telescope.builtin").current_buffer_fuzzy_find({ default_text = "## " })<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-g>', ':Telescope live_grep<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>]', ':Telescope grep_string<CR>', noremap)
vim.api.nvim_set_keymap('n', '<C-b>', ':Telescope buffers<CR>', noremap)

-- hover float
vim.api.nvim_set_keymap('n', '<Leader>p', ':lua vim.lsp.buf.hover()<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua vim.diagnostic.open_float(0, { scope = "line" })<CR>', noremap)

-- typescript lsp
vim.api.nvim_set_keymap('n', '<Leader>tg', ':TSToolsGoToSourceDefinition<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>ti', ':TSToolsAddMissingImports<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>tc', ':TSToolsOrganizeImports<CR>', noremap)

-- insert mode
---- movements
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', remap)
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', remap)
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', remap)
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', remap)
---- autocomplete on tab
vim.api.nvim_set_keymap('i', '<Tab>', '<C-n>', noremap)
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-p>', noremap)

-- visual mode
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', noremap)
vim.api.nvim_set_keymap('v', '<Leader>s', ':sort<CR>', noremap)
vim.api.nvim_set_keymap('v', '<Leader>.', ':normal .<CR>', noremap)
vim.api.nvim_set_keymap('v', '<', '<gv', noremap)
vim.api.nvim_set_keymap('v', '>', '>gv', noremap)
vim.api.nvim_set_keymap('v', 's', 'S', remap)

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
