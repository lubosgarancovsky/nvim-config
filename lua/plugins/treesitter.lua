return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup()

      local parsers = {
        "bash",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "tsx",
        "typescript",
      }

      treesitter.install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
