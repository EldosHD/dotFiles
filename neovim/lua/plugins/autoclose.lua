-- https://github.com/m4xshen/autoclose.nvim
-- autoclose brackets, quotes, etc
return {
  'm4xshen/autoclose.nvim',
  config = function()
    require('autoclose').setup()
  end,
}
