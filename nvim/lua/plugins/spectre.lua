local M = {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    use_trouble_qf = true,
  },
  keys = {
    {
      '<leader>F',
      function()
        require('spectre').toggle()
      end,
      desc = 'Toggle Spectre',
    },
  },
}

return M
