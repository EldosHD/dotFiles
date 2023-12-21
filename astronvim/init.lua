return {
  colorscheme = "catppuccin",
  plugins = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
    {
      'Exafunction/codeium.vim',
      event = 'BufEnter',
      config = function ()
        vim.keymap.set('i', '<C-l>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
      end
    }
  },
}
