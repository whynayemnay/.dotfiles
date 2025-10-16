return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    -- in this section, choose your own keymappings!
    {
      "<leader>pc",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>pw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
    yazi_floating_window_border = "none",
  },
}
