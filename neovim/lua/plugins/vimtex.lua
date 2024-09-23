return {
  'lervag/vimtex',
  init = function()
    vim.cmd 'syntax enable'

    vim.g.vimtex_compiler_enabled = 0
    vim.g.vimtex_view_enabled = 0
  end,
}
