return {

  settings = {
    ["rust-analyzer"] = {
      -- Check all features
      cargo = {
        allFeatures = true,
      },
      -- Run clippy on save.
      checkOnSave = {
        enable = true,
        command = "clippy",
      },
      disabled = { "unresolved-proc-macro" },
      procMacro = {
        ignored = {
          ['napi-derive'] = { 'napi' },
        },
      },
    },
  },
}
