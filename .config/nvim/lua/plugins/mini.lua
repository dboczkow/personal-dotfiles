return {
  {
    'nvim-mini/mini.animate',
    version = false,
    config = function()
      require('mini.animate').setup(
        {
          cursor = {
            enable = true,
          },
          scroll = {
            enable = true,
          },
          resize = {
            enable = true,
          },
          open = {
            enable = true,
          },
          close = {
            enable = true,
          },
        }
      )
    end
  },
  {
    'nvim-mini/mini.diff',
    version = false,
    config = function()
      require('mini.diff').setup(
        {
          -- Options for how hunks are visualized
          view = {
            style = vim.go.number and 'number' or 'sign',

            signs = { add = '▒', change = '▒', delete = '▒' },

            priority = 199,
          },

          source = nil,

          delay = {
            text_change = 200,
          },

          mappings = {
            apply = 'gh',
            reset = 'gH',
            textobject = 'gh',
            goto_first = '[H',
            goto_prev = '[h',
            goto_next = ']h',
            goto_last = ']H',
          },

          -- Various options
          options = {
            algorithm = 'histogram',
            indent_heuristic = true,
            linematch = 60,
            wrap_goto = false,
          },
        }
      )
    end
  },
  {
    'nvim-mini/mini.hipatterns',
    version = false,
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup(
        {
          -- Table with highlighters (see |MiniHipatterns.config| for more details).
          -- Nothing is defined by default. Add manually for visible effect.
          highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
            todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
            note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color({
              style = 'inline',
              inline_text = " "
            }),

          },

          -- Delays (in ms) defining asynchronous highlighting process
          delay = {
            -- How much to wait for update after every text change
            text_change = 200,

            -- How much to wait for update after window scroll
            scroll = 50,
          },

        }
      )
    end
  },
  {
    'nvim-mini/mini.comment',
    version = false,
    config = function()
      local comment = require('mini.comment')
      comment.setup()
    end
  }
}
