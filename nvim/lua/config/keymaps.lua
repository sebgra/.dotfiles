-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- In your lazy.nvim configuration for csvview.nvim
return {
  "hat0uma/csvview.nvim",
  keys = {
    { "<leader>v", "<cmd>CsvViewToggle delimiter=, display_mode=border header_lnum=1<cr>", desc = "Toggle CSV View" },
  },
  opts = { ... },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}