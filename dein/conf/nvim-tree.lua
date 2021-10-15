local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
        -- cd in the above directory
        { key = {"<CR>","o", "l", "<2-LeftMouse>"}, cb = tree_cb("edit") },

        -- will cd in the directory under the cursor
        { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },

        -- open the file in a vertical split
        { key = "<C-v>",                        cb = tree_cb("vsplit") },

        -- open the file in a horizontal split
        { key = "<C-x>",                        cb = tree_cb("split") },

        -- open the file in a new tab
        { key = "<C-t>",                        cb = tree_cb("tabnew") },

        -- navigate to the previous sibling of current file/directory
        { key = "<",                            cb = tree_cb("prev_sibling") },

        -- navigate to the next sibling of current file/directory
        { key = ">",                            cb = tree_cb("next_sibling") },

        -- paste from clipboard. Cut clipboard has precedence over copy
        { key = "P",                            cb = tree_cb("parent_node") },

        -- close current opened directory or parent
        { key = {"<BS>","h","<S-CR>"},                         cb = tree_cb("close_node") },

        -- open the file as a preview
        { key = "<Tab>",                        cb = tree_cb("preview") },

        -- navigate to the last sibling of current file/directory
        { key = "K",                            cb = tree_cb("first_sibling") },

        -- navigate to the first sibling of current file/directory
        { key = "J",                            cb = tree_cb("last_sibling") },

        -- toggle visibility of folders hidden via | nvim_tree_ignore
        { key = "I",                            cb = tree_cb("toggle_ignored") },

        -- toggle visibility of folders dotfiles
        { key = "H",                            cb = tree_cb("toggle_dotfiles") },

        -- refresh the tree
        { key = "R",                            cb = tree_cb("refresh") },

        -- addd a file
        { key = "a",                            cb = tree_cb("create") },

        -- delete a file (will prompt for confirmation)
        { key = "d",                            cb = tree_cb("remove") },

        -- rename a file
        { key = "r",                            cb = tree_cb("rename") },

        -- rename a file and omit the filename on input
        { key = "<C-r>",                        cb = tree_cb("full_rename") },

        -- add/remove file/directory to cut clipboard
        { key = "x",                            cb = tree_cb("cut") },

        -- copy a file/directory
        { key = "c",                            cb = tree_cb("copy") },

        -- paste a file/directory
        { key = "p",                            cb = tree_cb("paste") },

        -- copy a file/directory name
        { key = "y",                            cb = tree_cb("copy_name") },

        -- copy a file/directory path
        { key = "Y",                            cb = tree_cb("copy_path") },

        -- copy a file/directory absolute(絶対) path
        { key = "gy",                           cb = tree_cb("copy_absolute_path") },

        -- go to prev git item
        { key = "[c",                           cb = tree_cb("prev_git_item") },

        -- go to next git item
        { key = "]c",                           cb = tree_cb("next_git_item") },

        -- navigate up one directory
        { key = "-",                            cb = tree_cb("dir_up") },

        -- open a file with default system application or a folder with default file manager
        { key = "s",                            cb = tree_cb("system_open") },

        -- quit nvim-tree.lua
        { key = "q",                            cb = tree_cb("close") },

        -- see the help UI with keybindings
        { key = "g?",                           cb = tree_cb("toggle_help") },
}

require'nvim-tree'.setup{
        hijack_cursor = true, -- keeps the cursor on the first letter of the filename
        update_cwd = true,
        diagnostics = {
                enable =true,
        },
        view = {
                mappings = {
                        custom_only = true,
                        list = list,
                }
        },
}
