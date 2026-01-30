return {
{
  "stsewd/spotify.nvim",
  build = ":UpdateRemotePlugins",
  config = function()
    require("spotify").setup()
  end,
},
}
