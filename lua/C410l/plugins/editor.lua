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
      ---@diagnostic disable-next-line: different-requires
      return require("C410l.plugins.configs.telescope")
    end,
    config = function(_, opts)
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      local telescope = require("telescope")
      telescope.setup(opts.options)

      wk.add({
        { "<leader><space>", opts.project_files, desc = "Find File" },
        { "<leader>fb", builtin.buffers, desc = "Find Buffer" },
        { "<leader>ff", builtin.find_files, desc = "Find File" },
        { "<leader>fg", builtin.live_grep, desc = "Find with Grep" },
        { "<leader>fh", builtin.help_tags, desc = "Find Help" },
        { "<leader>fw", builtin.grep_string, desc = "Find Word" },
        { "<leader>gC", builtin.git_bcommits, desc = "Git Buffer Commits" },
        { "<leader>gS", builtin.git_status, desc = "Git Status" },
        { "<leader>gb", builtin.git_branches, desc = "Git Branches" },
        { "<leader>gc", builtin.git_commits, desc = "Git Commits" },
        { '<leader>s"', builtin.registers, desc = "Registers" },
        { "<leader>sC", builtin.commands, desc = "Commands" },
        { "<leader>sD", builtin.diagnostics, desc = "Workspace Diagnostics" },
        { "<leader>sH", builtin.highlights, desc = "Highlights" },
        { "<leader>sM", builtin.man_pages, desc = "Man Pages" },
        { "<leader>sR", builtin.resume, desc = "Resume" },
        { "<leader>sa", builtin.autocommands, desc = "Autocommands" },
        { "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "Buffer" },
        { "<leader>sc", builtin.command_history, desc = "Command History" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
        { "<leader>sh", builtin.help_tags, desc = "Help" },
        { "<leader>sj", builtin.jumplist, desc = "Jumplist" },
        { "<leader>sm", builtin.marks, desc = "Marks" },
        { "<leader>so", builtin.vim_options, desc = "Options" },
        { "<leader>sq", builtin.quickfix, desc = "Quickfix" },
        { "<leader>uC", builtin.colorscheme, desc = "Colorscheme" },
      })
    end,
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.add({
        "<leader>U",
        vim.cmd.UndotreeToggle,
        desc = "Undo Tree",
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
          ["Z"] = "expand_all_nodes",
        },
      },
    },
  },
}
