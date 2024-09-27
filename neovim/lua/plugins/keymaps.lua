local set = vim.keymap.set

return {
  -- Delete inside (){}[]<>"'
  set('n', '<leader>j', 'di(', { desc = 'Delete inside (' }),
  set('n', '<leader>k', 'di{', { desc = 'Delete inside {' }),
  set('n', '<leader>l', 'di[', { desc = 'Delete inside [' }),
  set('n', '<leader>h', 'di<', { desc = 'Delete inside <' }),
  set('n', '<leader>"', 'di"', { desc = 'Delete inside "' }),
  set('n', "<leader>'", "di'", { desc = "Delete inside '" }),
}
