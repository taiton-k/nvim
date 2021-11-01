local color_table = {
        file_info = {
                hl_modified = '#363654'
        },
        lsp = {
                errors = 'Darkred',
                warnings = 'Darkyellow',
                hints = 'Darkorange',
                info = 'cyan',
        },
}
local highlights = {
        vi_mode = function()
                return{
                        bg = require('feline.providers.vi_mode').get_mode_color(),
                        fg = 'black',
                        style = 'bold',
                }
        end,
        file = {
                info = function()
                        return {
                                bg = vim.bo.modified and color_table.file_info.hl_modified or 'bg',
                                fg = 'fg',
                        }
                end,
                info_sp = function()
                        return vim.bo.modified and {
                                str = '',
                                hl = {
                                        bg = 'bg',
                                        fg = color_table.file_info.hl_modified,
                                }
                        } or {
                                str = '',
                                hl = {
                                        fg = 'fg',
                                },
                        }
                end,
                info_sp_inactive = function()
                        return {
                                str = '',
                                hl = {
                                        bg = 'NONE',
                                        fg = vim.bo.modified and color_table.file_info.hl_modified or 'bg',
                                },
                        }
                end,
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
                                bg = require('feline.providers.lsp').diagnostics_exist('Error') and
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
                                bg = require('feline.providers.lsp').diagnostics_exist('Warning') and
                                     color_table.lsp.warnings or
                                     require('feline.providers.lsp').diagnostics_exist('Error') and
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
                                bg = require('feline.providers.lsp').diagnostics_exist('Hint') and
                                     color_table.lsp.hints or
                                     require('feline.providers.lsp').diagnostics_exist('Warning') and
                                     color_table.lsp.warnings or
                                     require('feline.providers.lsp').diagnostics_exist('Error') and
                                     color_table.lsp.errors or
                                     'NONE',
                        }
                end,
        },
        position_sp = function()
                return {
                        fg = 'bg',
                        bg = require('feline.providers.lsp').diagnostics_exist('Information') and
                             color_table.lsp.info or
                             require('feline.providers.lsp').diagnostics_exist('Hint') and
                             color_table.lsp.hints or
                             require('feline.providers.lsp').diagnostics_exist('Warning') and
                             color_table.lsp.warnings or
                             require('feline.providers.lsp').diagnostics_exist('Error') and
                             color_table.lsp.errors or
                             'NONE'
                }
        end,

        inactive = {
                fg = 'black',
                bg = '#727296',
                style = 'bold',
        },

        line = {
                fg = 'skyblue',
                bg = 'NONE',
        },
        line_inactive = {
                fg = 'green',
                bg = 'NONE',
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
                                        bg = highlights.file.info().bg,
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
                                        type = 'relative_short',
                                },
                        },
                        short_provider = 'file_info',
                        hl = highlights.file.info,
                        truncate_hide = true,
                        priority = 2,
                        left_sep = '█',
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
                hl = {
                        bg = 'bg',
                        fg = 'fg',
                },
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
                hl = {
                        fg = 'fg',
                        bg = 'bg',
                },
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
                hl = {
                        fg = 'fg',
                        bg = 'bg',
                },
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
                                        bg = highlights.file.info().bg,
                                }
                        end,
                },
        },
        file_info = {
                provider = {
                        name = 'file_info',
                        opts = {
                                type = 'relative_short',
                        },
                },
                short_provider = 'file_info',
                hl = highlights.file.info,
                truncate_hide = true,
                priority = 2,
                left_sep = '█',
                right_sep = highlights.file.info_sp_inactive,
        },

        line = {
                -- provider = '─',
                provider = '━',
                hl = highlights.line,
                truncate_hide = true,
                priority = -8,
        },
        line_inactive = {
                -- provider = '─',
                provider = '━',
                hl = highlights.line_inactive,
                truncate_hide = true,
                priority = -8,
        },

}

local middle = {}
for i=1 , 300 do
        middle[i] = components.line
end

local middle_inactive = {}
for i=1 , 300 do
        middle_inactive[i] = components.line_inactive
end

require('feline').setup {
        colors = {
                bg = '#000000',
                fg = '#EAEAFF',
                black = '#000000',
                green = '#608b4e',
        },
        vi_mode_colors = {
                ['COMMAND'] = 'yellow',
        },
        components = {
                active = {
                        {
                                components.vi_mode,
                                components.file.info,
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
