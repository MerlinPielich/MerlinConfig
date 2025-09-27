return {
        'joshuadanpeterson/typewriter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('typewriter').setup({
        enable_horizontal_scroll = false,
        keep_cursor_position = false,
        always_center = true,
        })
        end,
        opts = {
    }
    }
