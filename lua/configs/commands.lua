local command = vim.api.nvim_create_user_command
command('Help', 'vert help <args>', {nargs = '*', complete = 'help'})

command('RunCommand', 'TermExec cmd="<args>" go_back=0', {nargs = "*"})
command('OjTest', 'RunCommand oj t -N -d tests', {})
command('Submit', 'RunCommand quom main.cpp submit.cpp -I ~/Documents/KyouPuro/c++/ && acc submit', {})
command('Acc', 'RunCommand acc <args>', {nargs = '*'})
command('Execute', 'RunCommand ./a.out', {})
command('Compile', 'RunCommand make <args>', {nargs = '*'})
