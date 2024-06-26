-- plugins related to the editor

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = function()
      return require("C410l.plugins.configs.telescope")
    end,
    config = function(_, opts)
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      local telescope = require("telescope")
      telescope.setup(opts.options)

      wk.register({
        ["<space>"] = { opts.project_files, "Find File" },
        f = {
          f = { builtin.find_files, "Find File" },
          b = { builtin.buffers, "Find Buffer" },
          g = { builtin.live_grep, "Find with Grep" },
          h = { builtin.help_tags, "Find Help" },
          w = { builtin.grep_string, "Find Word" },
        },
        s = {
          ['"'] = { builtin.registers, "Registers" },
          a = { builtin.autocommands, "Autocommands" },
          b = { builtin.current_buffer_fuzzy_find, "Buffer" },
          c = { builtin.command_history, "Command History" },
          C = { builtin.commands, "Commands" },
          d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
          D = { builtin.diagnostics, "Workspace Diagnostics" },
          h = { builtin.help_tags, "Help" },
          H = { builtin.highlights, "Highlights" },
          j = { builtin.jumplist, "Jumplist" },
          M = { builtin.man_pages, "Man Pages" },
          m = { builtin.marks, "Marks" },
          o = { builtin.vim_options, "Options" },
          R = { builtin.resume, "Resume" },
          q = { builtin.quickfix, "Quickfix" },
        },
        g = {
          c = { builtin.git_commits, "Git Commits" },
          C = { builtin.git_bcommits, "Git Buffer Commits" },
          S = { builtin.git_status, "Git Status" },
          b = { builtin.git_branches, "Git Branches" },
        },
        uC = { builtin.colorscheme, "Colorscheme" },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>U"] = {
          vim.cmd.UndotreeToggle,
          "Undo Tree",
        },
      })
    end,
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    opt = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      {
        settings = {
          save_on_toggle = true,
        },
      },
    },
    keys = function()
      local harpoon = require("harpoon")
      local keys = {
        {
          "<leader>a",
          function()
            harpoon:list():add()
          end,
          desc = "Harpoon Add File",
        },
        {
          "<C-e>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Toggle Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            harpoon:list():select(i)
          end,
          desc = "Harpoon File " .. i,
        })
      end

      return keys
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    --
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require("C410l.plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    cmd = { "Oil" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer (Oil)" },
    },
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    deactive = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            ---@diagnostic disable-next-line: param-type-mismatch
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy path to Clipboard",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
    },
  },
}
