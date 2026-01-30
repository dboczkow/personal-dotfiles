return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim"
    },
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })    -- pink
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" }) -- peach
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })   -- blue
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" }) -- peach
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })  -- green
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" }) -- mauve
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })   -- teal
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      require("ibl").setup {
        scope = {
          highlight = highlight
        }
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
