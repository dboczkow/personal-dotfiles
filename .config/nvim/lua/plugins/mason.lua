return {
  {
    "mason-org/mason.nvim",
    opts = {},
    config = function()
      require('mason').setup({ 
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        }
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls' },
      })
    end
  }
}
