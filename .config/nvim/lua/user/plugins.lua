--------------------------
-- Plugins configuration
--------------------------
vim.g.loaded_clipboard_provider = 1

-- -- Create default mappings
-- vim.g.NERDCreateDefaultMappings = 1
-- -- Add spaces after comment delimiters
-- vim.g.NERDSpaceDelims = 1
-- -- Use compacct syntax for prettified multi-line comments
-- vim.g.NERDCompactSexyComs = 1
-- -- Align line-wise comment delimiters flush left instead of following code
-- -- identation
-- vim.g.NERDDefaultAlgin = "left"
-- -- Enable NERDCommenterToggle to check all selected lines is commented or not
-- vim.g.NERDToggleCheckAllLines = 1
-- 
-- vim.g.any_jump_search_prefered_engine = "rg"

vim.api.nvim_create_user_command("Todo", ":vimgrep /TODO/gj src/**/*.[ch] | copen", { nargs = 0 })
