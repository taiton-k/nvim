let g:nvim_tree_highlight_opened_files = 3 " Enable highligting for opened folders and file both icons and names
let g:nvim_tree_quit_on_open = 1 " close the tree when a file is opened
let g:nvim_tree_indent_markers = 0 " display indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 " Not hide dotfiles
let g:nvim_tree_group_empty = 0 " folders that contain only one folder are grouped
let g:nvim_tree_disable_window_picker = 1 " disable the window picker
let g:nvim_tree_window_picker_chars = "ASDFGHJKL1234567890" "  string of chars used as identifiers by the window picker

nnoremap <C-n> :NvimTreeToggle<CR>

autocmd conf FileType NvimTree setlocal tabstop=2 shiftwidth=2
