return { {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    -- 'nvim-telescope/telescope-file-browser.nvim',
    'luissimas/telescope-nodescripts.nvim'
  },
  config = function()
    require('telescope').setup {
      extensions = {
        -- file_browser = {
        --   cwd_to_path = true,
        --   theme = "ivy",
        --   hijack_netrw = true,
        -- },
        nodescripts = {
          command = "pnpm run",
          display_method = "h_split"
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {}
        }
      }
    }

    require('telescope').load_extension "ui-select"
    -- require("telescope").load_extension "file_browser"
    require('telescope').load_extension "nodescripts"
  end
},
}
