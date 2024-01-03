return {
  -- Available settings can be found in the mason menu
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          -- E203 conflicts with black https://github.com/psf/black/issues/315, ignore it.
          ignore = {'W391', 'E203'},
          maxLineLength = 120
        },
      },
    },
  },
}
