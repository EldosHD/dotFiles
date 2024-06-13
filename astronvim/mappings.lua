return {
  n = {
    ["<leader>k"] = { "di{", desc = "delete inner {}" },
    ["<leader>j"] = { "di(", desc = "delete inner ()" },
    ["<leader>l"] = { "di[", desc = "delete inner []" },
    ["<leader>h"] = { "di<", desc = "delete inner <>" },
    ["<leader>\""] = { "di\"", desc = "delete inner double quotes" },
    ["<leader>'"] = { "di'", desc = "delete inner single quotes" },

    -- buffers
    ["<leader>bn"] = { "<cmd>bn<cr>", desc = "Next buffer" },
    ["<leader>bN"] = { "<cmd>bp<cr>", desc = "Previous buffer" },
  }
}
