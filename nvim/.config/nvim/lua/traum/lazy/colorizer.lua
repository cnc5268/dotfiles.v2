return {
  "norcalli/nvim-colorizer.lua",
  config = function ()
  require("colorizer").setup({
  "*",
  css = {css = true; rgb_fn = true;},
  html = {names = true},
  })
  end
}
