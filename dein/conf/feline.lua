local color_table = {
        file_info = {
                hl_modified = '#363636'
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
                                     'NONE'
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
                                     color_table.lsp.hints,
                                     'NONE'
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
}

local components = {
        vi_mode = {
                provider = 'vi_mode',
                hl = highlights.vi_mode,
                left_sep = 'block',
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
                        left_sep = '█',
                        right_sep = highlights.file.info_sp,
                },
                size = {
                        provider = 'file_size',
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
                right_sep = '█',
        },
}


require('feline').setup {
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
                                {hl = {bg = 'NONE'}}
                        },
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
                },
        }
}
