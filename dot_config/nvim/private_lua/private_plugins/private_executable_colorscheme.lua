vim.o.background = "dark"
vim.cmd("colorscheme habamax")

return {
  {
    "tomasiser/vim-code-dark",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    "namrabtw/rusty.nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup({
        style = 'multiplex', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      })
      -- vim.cmd("colorscheme bamboo")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({});
      vim.cmd("colorscheme kanagawa-dragon")
    end
  },
}
