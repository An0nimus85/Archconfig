-- Загрузка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- всегда стабильная версия
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Настройка lazy.nvim
require("lazy").setup({
  -- Treesitter для подсветки синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "html", "css" }, -- добавь нужные языки
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
	-- Цветовая схема и прозрачность окна
{
  "folke/tokyonight.nvim",
  priority = 1000, -- Убедимся, что загружается в первую очередь
  config = function()
    require("tokyonight").setup({
      style = "night", -- Стиль темы: night, storm, day, moon
      transparent = true, -- Прозрачность окна
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })
    vim.cmd("colorscheme tokyonight") -- Применяем цветовую схему
  end,
},


  -- LSP-конфигурация
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.ts_ls.setup({})
    end,
  },

  -- Автодополнение через nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Улучшение интерфейса: строка состояния
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        options = { theme = "gruvbox" },
      })
    end,
  },

  -- Файловый менеджер
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- Телескоп для поиска файлов
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },
})
vim.opt.number = true
vim.opt.relativenumber = true  -- Относительная нумерация строк

