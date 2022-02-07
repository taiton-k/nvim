local o = vim.o;

local defaults = {};

defaults.ruler = {
        components = {
                left = {
                        
                };
                middle = {
                        
                };
                right = {
                        
                };
        };
};
defaults.statusline = {
        components = {
                
        };
};
defaults.floatingline = {
        window_options = {
                relative = "editor";
                anchor = "NW";
                width = o.width;
                height = 1;
                col = 1;
                row = o.lines-o.cmdheight-1;
                focusable = false;
                style = "minimal";
                border = "none";
        };
        components = {
                
        };
}
defaults.tabline = {
        use = true;
        components = {
                
        };
};

return defaults;
