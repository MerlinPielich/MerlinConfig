return {
  "Laellekoenig/marky-mark.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim"
  },
  config = function()
    require("marky-mark").setup({
      use_default_keymap = true,  --set to false to use own keybindings, e.g. to not overwrite m
      zz_after_jump = true,  --center the screen after jumping to a mark
      popup_width = 35,
    })
  end
}

