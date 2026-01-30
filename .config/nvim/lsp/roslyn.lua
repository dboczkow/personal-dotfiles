local lspconfig = require("lspconfig")
local mason_registry = require("mason-registry")

local roslyn = mason_registry.get_package("roslyn")
local roslyn_cmd = { roslyn:get_install_path() .. "/roslyn" }

lspconfig.roslyn.setup({
  cmd = { roslyn_cmd[1], "--logLevel=Information", "--stdio" },
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),

  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_parameters = true,
      csharp_enable_inlay_hints_for_literal_parameters = true,
      csharp_enable_inlay_hints_for_other = { enabled = true },
      csharp_enable_inlay_hints_for_lambdas = true,
    },
  },

  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Toggle inlay hints
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, opts)
  end,

  capabilities = vim.lsp.protocol.make_client_capabilities(),
})
