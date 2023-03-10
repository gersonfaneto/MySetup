local hadSuccess, NullLS = pcall(require, "null-ls")

if not hadSuccess then
  return
end

local Formatting = NullLS.builtins.formatting
local CodeActions = NullLS.builtins.code_actions
local Diagnostics = NullLS.builtins.diagnostics

local sources = {
  Formatting.eslint_d,
  Formatting.autopep8,
  Formatting.stylua,
  Formatting.clang_format,
  Formatting.stylelint,
  Formatting.prettier,

  CodeActions.eslint_d,

  Diagnostics.eslint_d,
}

NullLS.setup({
  sources = sources,
  on_attach = on_attach,
})
