return {
  -- Autopairs
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = true,
  -- },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- Surround (ds, cs, ys motions)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
    enabled = true,
    debounce = 200,
    viewport_buffer = {
        min = 30,
        max = 500,
    },
    indent = {
        char = "┊",
                tab_char = "│",
        highlight = "IblIndent",
        smart_indent_cap = true,
        priority = 1,
        repeat_linebreak = true ,
    },
    whitespace = {
        highlight = "IblWhitespace",
        remove_blankline_trail = true,
    },
    scope = {
        enabled = true,
        char =  "│",  -- Uses indent.char if nil
        show_start = true,
        show_end = true,
        show_exact_scope = false,
        injected_languages = true,
        highlight = "IblScope",
        priority = 1024,
        include = {
            node_type = {},
        },
        exclude = {
            language = {},
            node_type = {
                ["*"] = {
                    "source_file",
                    "program",
                },
                lua = {
                    "chunk",
                },
                python = {
                    "module",
                },
            },
        },
    },
    exclude = {
        filetypes = {
            "lspinfo", "packer", "checkhealth", "help", "man",
            "gitcommit", "TelescopePrompt", "TelescopeResults", ""
        },
        buftypes = {
            "terminal", "nofile", "quickfix", "prompt"
                    },
            }
        },
    },
}
