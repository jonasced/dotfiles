local M = {}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if status_ok then
    -- vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
    -- local git_blame = require("gitblame")
    local config = {
      options = {
          disabled_filetypes = { "NvimTree", "neo-tree", "dashboard", "alpha" },
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 30)
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              fmt = function(str)
                return str:sub(1, 25)
              end,
            },
            "diff",
            {
              "diagnostics",
              symbols = {
                error = "E ",
                warn = "W ",
                info = "H ",
                hint = "H ",
              },
            },
          },
          lualine_c = {
                  -- Display number of loaded buffers
            {
              function()
                local is_loaded = vim.api.nvim_buf_is_loaded
                local tbl = vim.api.nvim_list_bufs()
                local loaded_bufs = 0
                for i = 1, #tbl do
                  if is_loaded(tbl[i]) then
                    loaded_bufs = loaded_bufs + 1
                  end
                end
                return loaded_bufs
              end,
              icon = "󰘳",
              color = { fg = "DarkCyan", gui = "bold" },
            },

            {
              "filename",
              shorting_target = 40,
              file_status = true,
              path = 2,
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        winbar = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              fmt = function(str)
                return str:sub(1, 25)
              end,
            },
            "diff",
            {
              "diagnostics",
              symbols = {
                error = "E ",
                warn = "W ",
                info = "H ",
                hint = "H ",
              },
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 2,
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {
            {
              "branch",
              fmt = function(str)
                return str:sub(1, 25)
              end,
            },
            "diff",
            {
              "diagnostics",
              symbols = {
                error = "E ",
                warn = "W ",
                info = "H ",
                hint = "H ",
              },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
    }

    lualine.setup(config)
  end
end

return M
