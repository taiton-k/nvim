local command = vim.api.nvim_create_user_command
command('Help', 'vert help <args>', {nargs = '*', complete = 'help'})

command('OjTest', 'TermExec cmd="oj t -N -d tests"', {})
command('Submit', 'TermExec cmd="quom main.cpp submit.cpp -I ~/Documents/KyouPuro/c++/ && acc submit"', {})
command('Acc', 'TermExec cmd="acc <args>"', {nargs = '*'})
command('Execute', 'TermExec cmd="./a.out"', {})
command('Compile', 'TermExec cmd="make <args>"', {nargs = '*'})
