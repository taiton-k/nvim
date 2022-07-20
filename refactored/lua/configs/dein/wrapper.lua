local plugins = require("configs.pluginlist").pluginlist

local wrapper = {
        hook_functions = {},
        ftplugin_functions = {},
        plugins = plugins
}

local set_hook_functions = function (repo, hook)
        wrapper.hook_functions[repo][hook], plugins[repo][hook] =
                plugins[repo][hook], nil

        plugins[repo][hook] =
        "lua require('configs.dein.wrapper').hook_functions['" ..
        repo ..
        "']['" ..
        hook ..
        "']()"
end

local set_ftplugin_functions = function (repo)
        wrapper.ftplugin_functions[repo] = {}

        for ft, _ in pairs(plugins[repo]["ftplugin"]) do

                if type(plugins[repo]["ftplugin"][ft]) == "function" then
                        wrapper.ftplugin_functions[repo][ft], plugins[repo]["ftplugin"][ft] = plugins[repo]["ftplugin"][ft], nil
                        plugins[repo]["ftplugin"][ft] =
                        "lua require('configs.dein.wrapper').ftplugin_functions['" ..
                        repo ..
                        "']['" ..
                        ft ..
                        "']()"
                end
        end
end

for repo, opts in pairs(plugins) do

        wrapper.hook_functions[repo] = {}

        for item, value in pairs(opts) do

                if type(value) == "function" then
                        set_hook_functions(repo, item)
                elseif item == "ftplugin" then
                        set_ftplugin_functions(repo)
                end
        end
end



return wrapper
