return {
  -- Available settings can be found in the mason menu
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 120
        },
      },
    },
  },
}
