return {
    -- Fasto file fuzzy finding
    {
        "junegunn/fzf",
        build = function()
            vim.fn["fzf#install"]()
        end,
    },
    {
        "junegunn/fzf.vim",
        init = function()
            vim.g.fzf_preview_window = {}
            vim.g.fzf_layout = { down = "30%" }
            -- vim.g.fzf_action = {
                -- ["ctrl-q"] = function("s:build_quickfix_list"),
                -- ["ctrl-q"] = function(lines)
                    -- vim.cmd [[
                        -- call setqflist(map(copy(a:lines), "{ "filename": v:val, "lnum": 1 }"))
                        -- copen
                        -- cc
                    -- ]]
                -- end,
                -- ["ctrl-q"] = vim.fn["s:build_quickfix_list"],
                -- ["ctrl-s"] = "split",
                -- ["ctrl-v"] = "vsplit"
            -- }
        end,
        config = function()
            -- vim.cmd [[
                -- function! s:build_quickfix_list(lines)
                  -- call setqflist(map(copy(a:lines), '{ 'filename': v:val, 'lnum': 1 }"))
                  -- " copen
                  -- " cc
                -- endfunction
                -- let g:fzf_action = { 'ctrl-a': function('s:build_quickfix_list'), 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }

                -- function! RipgrepFzf(query, fullscreen)
                  -- let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
                  -- let initial_command = printf(command_fmt, shellescape(a:query))
                  -- let reload_command = printf(command_fmt, '{q}')
                  -- let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
                  -- call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
                -- endfunction

                -- command! -nargs=* -bang Salut call RipgrepFzf(<q-args>, <bang>0)
            -- ]]

            vim.api.nvim_create_user_command(
                "RipGrep",
                "call fzf#run(fzf#wrap({ \'source\': \'rg --files --hidden --glob=!.git/\' }))",
                { nargs = "*", bang = true }
            )
        end,
    },
}
