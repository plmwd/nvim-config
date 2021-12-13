nnoremap ; :
nnoremap : ;

nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>. <cmd>Telescope find_files<cr>
nnoremap <leader>] gt
nnoremap <leader>[ gT

" Fuzzy finders
nnoremap <leader>fF <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader><space> <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fe <cmd>lua require('telescope.builtin').file_browser({cwd = require('telescope.utils').buffer_dir()})<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fM <cmd>Telescope media_files<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>fj <cmd>Telescope symbols<cr>
nnoremap <leader>fca <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME'})<cr>
nnoremap <leader>fcn <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/nvim'})<cr>
nnoremap <leader>fcx <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/xmonad'})<cr>
nnoremap <leader>fcs <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/sway'})<cr>
nnoremap <leader>fck <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/kitty'})<cr>
nnoremap <leader>fcd <cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/repos/dwm'})<cr>

" Terminal
" nnoremap <leader>tt <cmd>ToggleTerm<cr>
" nnoremap <leader>tf <cmd>ToggleTerm direction=float<cr>
tnoremap <c-j><c-k> <c-\><c-n>
tnoremap <c-]> <c-\><c-n> <bar> <cmd>2ToggleTerm<cr>
tnoremap <c-h> <c-\><c-n><c-W>h
tnoremap <c-j> <c-\><c-n><c-W>j
tnoremap <c-k> <c-\><c-n><c-W>k
tnoremap <c-l> <c-\><c-n><c-W>l

" Git
nnoremap <leader>gg <cmd>Neogit<cr>
nnoremap <leader>gc <cmd>Neogit commit<cr>
nnoremap <leader>gb <cmd>Git blame<cr>

" LSP
nnoremap <leader>lr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>lw <cmd>Telescope lsp_workspace_symbols<cr>

" Diagnostics (trouble)
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" Plugin management (packer)
nnoremap <leader>pc <cmd>PackerCompile<cr>
nnoremap <leader>ps <cmd>PackerSync<cr>

" Debugging (nvim-dap)
nnoremap <leader>db <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>dc <cmd>lua require'dap'.continue()<cr>
nnoremap <leader>di <cmd>lua require'dap'.step_into()<cr>
nnoremap <leader>do <cmd>lua require'dap'.step_over()<cr>
nnoremap <leader>dr <cmd>lua require'dap'.repl.open()<cr>

" Other
nnoremap <leader>z <cmd>ZenMode<cr>
nnoremap <leader>? <cmd>Cheatsheet<cr>
nnoremap <esc> <cmd>noh<cr>
nnoremap cp <cmd>ISwap<cr>
nnoremap cP <cmd>ISwapWith<cr>
nnoremap <C-s> <cmd>w<cr>
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <bs> <C-^>
nnoremap <leader><tab> <C-w>w
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>w= <C-w>=
nnoremap <leader>W <cmd>w<cr>
nnoremap <leader>wq <cmd>wq<cr>
nnoremap <leader>q <cmd>q<cr>
nnoremap <leader>wQ <cmd>wqa<cr>
nnoremap / ms/
nnoremap ? ms?
nnoremap * ms*
map f <cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>
map F <cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>
map t <cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>
map T <cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>
nnoremap gl <cmd>HopLineStart<cr>

inoremap <C-e> <cmd>noh<cr>
inoremap <C-s> <cmd>w<cr>
nnoremap <C-j> <cmd>cprev<cr>
nnoremap <C-k> <cmd>cnext<cr>