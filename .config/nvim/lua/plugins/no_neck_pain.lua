return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      require("no-neck-pain").setup({
        autocmds = { enableOnVimEnter = false },
        mappings = { enabled = false },
      })

      -- custom keymap
      vim.keymap.set("n", "<leader>pp", "<cmd>NoNeckPain<cr>", {
        desc = "Toggle NoNeckPain",
      })
    end,
  },
}
