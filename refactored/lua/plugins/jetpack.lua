vim.cmd('packadd vim-jetpack')

local jetpack = require('jetpack')
local pluginlist = require('plugins.pluginlist').pluginlist

for _, name in ipairs(jetpack.names()) do
        if jetpack.tap(name) then
                jetpack.sync()
                break
        end
end

for _, plugin in pairs(pluginlist) do

        if plugin.post then
                local name = plugin.as or vim.fn.substitute(vim.fn.fnamemodify(plugin[1], ':t'), [[*/]], '', '')
                local event = vim.fn.substitute(name, [[\W\+]], '_', 'g')
                event = vim.fn.substitute(event, [[\(^\|_\)\(.\)]], [[\u\2]], 'g')

                vim.api.nvim_create_autocmd(
                        "User",
                        {
                                pattern = {'Jetpack' .. event .. 'Post'},
                                callback = plugin.post,
                                once = true
                        }
                )

                plugin.post = nil
        end

        if plugin.requires then
                local name = vim.fn.substitute(vim.fn.fnamemodify(plugin.requires, ':t'), [[*/]], '', '')
                local event = vim.fn.substitute(name, [[\W\+]], '_', 'g')
                event = vim.fn.substitute(event, [[\(^\|_\)\(.\)]], [[\u\2]], 'g')
                event = 'Jetpack' .. event .. 'Post'

                if type(plugin.event) == 'string' then
                        plugin.event = {plugin.event, event}
                elseif type(plugin.event) == 'table' then
                        plugin.event:append(event)
                else
                        plugin.event = event
                end

                plugin.requires = nil
        end
end

jetpack.setup(
        pluginlist
)
