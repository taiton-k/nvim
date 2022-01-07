
local nord = {
        --16 colors
        bg = "#2E3440",-- nord0
        mode_fg = "#0E1420",
        white = '#FFFFFF',
        nord1 = "#3B4252",
        nord2_gui = "#434C5E",
        nord3 = "#4C566A",
        --nord3_gui_bright = "#616E88" ,
        normal = "#D8DEE9",--nord4
        nord5_gui = "#E5E9F0",
        fg = "#ECEFF4",
        nord7_gui = "#8FBCBB",
        skyblue = "#88C0D0",
        oceanblue = "#81A1C1",
        nord10 = "#5E81AC",
        red = "#BF616A",
        orange = "#D08770",
        yellow = "#EBCB8B",
        green = "#A3BE8C",
        violet = "#B48EAD" ,
        none =  'NONE'
}


local color_table = {
        lsp = {
                errors = 'red',
                warnings = 'Orange',
                hints = 'LightBlue',
                info = '#81A1C1',
        },

        inactive = 'oceanblue',
}

local highlights = {
        vi_mode = function()
                return{
                        bg = require('feline.providers.vi_mode').get_mode_color(),
                        fg = 'mode_fg',
                        style = 'bold',
                }
        end,
        file = {
                info = {
                        bg = 'bg',
                        fg = 'fg'
                },
                info_sp = {
                        str = '',
                        hl = {
                                fg = 'fg',
                        },
                        always_visible = true,
                },
                modified = {
                        fg = 'orange',
                        bg = 'bg',
                },
                info_sp_inactive = {
                        str = '',
                        hl = {
                                bg = 'NONE',
                                fg = 'bg',
                        },
                        always_visible = true,
                },
        },
        lsp = {
                errors = {
                        bg = color_table.lsp.errors,
                        fg = 'black',
                },
                errors_sp = {
                        fg = color_table.lsp.errors,
                        bg = 'NONE',
                },
                warnings = {
                        bg = color_table.lsp.warnings,
                        fg = 'black',
                },
                warnings_sp = function()
                        return {
                                fg = color_table.lsp.warnings,
                                bg = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR) and
                                     color_table.lsp.errors or
                                     'NONE'
                        }
                end,
                hints = {
                        bg = color_table.lsp.hints,
                        fg = 'black',
                },
                hints_sp = function()
                        return {
                                fg = color_table.lsp.hints,
                                bg = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.WARN) and
                                     color_table.lsp.warnings or
                                     require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR) and
                                     color_table.lsp.errors or
                                    'NONE',
                        }
                end,
                info = {
                        bg = color_table.lsp.info,
                        fg = 'black',
                },
                info_sp = function()
                        return {
                                fg = color_table.lsp.info,
                                bg = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.HINT) and
                                     color_table.lsp.hints or
                                     require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.WARN) and
                                     color_table.lsp.warnings or
                                     require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR) and
                                     color_table.lsp.errors or
                                     'NONE',
                        }
                end,
        },
        position_sp = function()
                return {
                        fg = 'bg',
                        bg = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.INFO) and
                             color_table.lsp.info or
                             require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.HINT) and
                             color_table.lsp.hints or
                             require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.WARN) and
                             color_table.lsp.warnings or
                             require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR) and
                             color_table.lsp.errors or
                             'NONE'
                }
        end,
        scroll_bar = {
                fg = 'violet',
        },

        inactive = {
                fg = 'black',
                bg = color_table.inactive,
                style = 'bold',
        },

        line = function()
                return {
                        fg = require('feline.providers.vi_mode').get_mode_color(),
                        bg = 'NONE',
                }
        end,
        line_inactive = {
                fg = color_table.inactive,
                bg = 'NONE',
        },

        normal = {
                bg = 'bg',
                fg = 'fg',
        },
}

local components = {
        vi_mode = {
                provider = 'vi_mode',
                hl = highlights.vi_mode,
                left_sep = '█',
                right_sep = {
                        str = '',
                        hl = function()
                                return {
                                        fg = highlights.vi_mode().bg,
                                        bg = highlights.file.info.bg,
                                }
                        end,
                },
                icon = '',
        },
        file = {
                info = {
                        provider = {
                                name = 'file_info',
                                opts = {
                                        file_modified_icon = "",
                                        file_readonly_icon = "🔒 ",
                                        type = 'relative',
                                },
                        },
                        hl = highlights.file.info,
                        truncate_hide = true,
                        priority = 2,
                        left_sep = '█',
                        right_sep = '█',
                },
                modified = {
                        provider = function()
                                return vim.bo.modified and '●  ' or ''
                        end,
                        hl = highlights.file.modified,
                        priority = 2,
                        right_sep = highlights.file.info_sp,
                },
                size = {
                        provider = 'file_size',
                        truncate_hide = true,
                        priority = 1,
                        left_sep = ' ',
                        right_sep = {
                                str = ' ',
                                hl = {
                                        fg = 'fg',
                                }
                        },
                },
                encoding = {
                        provider = 'file_encoding',
                        truncate_hide = true,
                        priority = 1,
                        left_sep = ' ',
                        right_sep = {
                                str = '█',
                                hl = {
                                        fg = 'bg',
                                        bg = 'NONE',
                                },
                        },
                },
        },
        lsp = {
                errors = {
                        provider = 'diagnostic_errors',
                        hl = highlights.lsp.errors,
                        left_sep = {
                                str = '',
                                hl = highlights.lsp.errors_sp,
                        },
                        right_sep = '█',
                        icon = '',
                        enable = function()
                                return require('feline.providers.lsp').diagnostics_exist('Error')
                        end,
                },
                warnings = {
                        provider = 'diagnostic_warnings',
                        hl = highlights.lsp.warnings,
                        left_sep = {
                                str = '',
                                hl = highlights.lsp.warnings_sp,
                        },
                        right_sep = '█',
                        icon = '',
                        enable = function()
                                return require('feline.providers.lsp').diagnostics_exist('Warning')
                        end,
                },
                hints = {
                        provider = 'diagnostic_hints',
                        hl = highlights.lsp.hints,
                        left_sep = {
                                str = '',
                                hl = highlights.lsp.hints_sp,
                        },
                        right_sep = '█',
                        icon = '',
                        enable = function()
                                return require('feline.providers.lsp').diagnostics_exist('Hint')
                        end,
                },
                info = {
                        provider = 'diagnostic_info',
                        hl = highlights.lsp.info,
                        left_sep = {
                                str = '',
                                hl = highlights.lsp.info_sp,
                        },
                        right_sep = '█',
                        icon = '',
                        enable = function()
                                return require('feline.providers.lsp').diagnostics_exist('Information')
                        end,
                },
        },
        position = {
                provider = 'position',
                hl = highlights.normal,
                truncate_hide = true,
                priority = -1,
                left_sep = {
                        str = '█',
                        hl = highlights.position_sp,
                },
                right_sep = '█',
        },
        percentage = {
                provider = 'line_percentage',
                hl = highlights.normal,
                truncate_hide = true,
                priority = 0,
                left_sep = {
                        str = ' ',
                        hl = {
                                fg = 'fg',
                                bg = 'bg',
                        },
                },
                right_sep = '█',
        },
        scroll_bar = {
                provider = 'scroll_bar',
                hl = highlights.scroll_bar,
                truncate_hide = true,
                priority = 0,
                right_sep = '█',
        },


        type = {
                provider = function()
                        return vim.bo.filetype=='' and ( vim.bo.buftype=='' and  'INACTIVE' or vim.bo.buftype:upper() ) or vim.bo.filetype:upper()
                end,
                hl = highlights.inactive,
                left_sep = '█',
                right_sep = {
                        str = '',
                        hl = function()
                                return {
                                        fg = highlights.inactive.bg,
                                        bg = highlights.file.info.bg,
                                }
                        end,
                },
        },
        file_info = {
                provider = {
                        name = 'file_info',
                        opts = {
                                file_modified_icon = "",
                                file_readonly_icon = "🔒 ",
                                type = 'relative_short',
                        },
                },
                hl = highlights.file.info,
                truncate_hide = true,
                priority = 2,
                left_sep = '█',
        },
        file_modified = {
                provider = function()
                        return vim.bo.modified and '● ' or ''
                end,
                hl = highlights.file.modified,
                priority = 2,
                right_sep = highlights.file.info_sp_inactive,
        },

        line = {
                --provider = '─',
                provider = '—',
                --provider = '━',
                hl = highlights.line,
                truncate_hide = true,
                priority = -8,
        },
        line_inactive = {
                --provider = '─',
                --provider = '━',
                provider = '—',
                hl = highlights.line_inactive,
                truncate_hide = true,
                priority = -8,
        },

}

local middle = {}
for i=1 , 200 do
        middle[i] = components.line
end

local middle_inactive = {}
for i=1 ,200 do
        middle_inactive[i] = components.line_inactive
end

--require('feline').use_theme(nord)

require('feline').add_theme('nord',nord)

require('feline').use_theme('nord')

require('feline').setup {
        --[[colors = {
                bg = '#000000',
                fg = '#EAEAFF',
                black = '#000000',
                red = '#BF616A',
                green = '#608b4e',
                yellow = '#EBCB8B',
        },]]
        --colors = nord,
        theme = 'nord',
        vi_mode_colors = {
                ['COMMAND'] = 'yellow',
        },
        components = {
                active = {
                        {
                                components.vi_mode,
                                components.file.info,
                                components.file.modified,
                                components.file.size,
                                components.file.encoding,
                        },
                        middle,
                        {
                                components.lsp.errors,
                                components.lsp.warnings,
                                components.lsp.hints,
                                components.lsp.info,
                                components.position,
                                components.percentage,
                                components.scroll_bar,
                        },
                },
                inactive = {
                        {
                                components.type,
                                components.file_info,
                                components.file_modified,
                                {hl = {bg = 'NONE'}}
                        },
                        middle_inactive,
                        {
                                components.lsp.errors,
                                components.lsp.warnings,
                                components.lsp.hints,
                                components.lsp.info,
                        }
                },
        }
}
