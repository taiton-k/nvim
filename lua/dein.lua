local fn = vim.fn;
local o = vim.o;
local cmd = vim.cmd;

local dein_dir = fn.expand("~/.cache/dein");
local dein_repo_dir = dein_dir .. "/repos/github.com/Shougo/dein.vim";

if not string.match(o.runtimepath, "/dein.vim") then
        if fn.isdirectory(dein_repo_dir) ~= 1 then
                os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir);
        end
        --opt.runtimepath:prepend(fn.fnamemodify(dein_repo_dir, ":p"));
        o.runtimepath = fn.fnamemodify(dein_repo_dir,":p") .. ',' .. o.runtimepath;
end

if (fn["dein#load_state"](dein_dir) == 1) then
        fn["dein#begin"](dein_dir);

--       local toml_dir = fn.expand("~/.config/nvim/");

--       fn["dein#load_toml"](toml_dir .. "dein.toml", {lazy = 0});
--       fn["dein#load_toml"](toml_dir .. "lazy.toml", {lazy = 1});

        local toml_dir = fn.expand("~/.config/nvim/dein/");
        fn["dein#load_toml"](toml_dir .. "dein.toml", {lazy = 0});
        fn["dein#load_toml"](toml_dir .. "deco.toml", {lazy = 0});
        fn["dein#load_toml"](toml_dir .. "lazy.toml", {lazy = 1});

        fn["dein#end"]();
        fn["dein#save_state"]();
end

fn["dein#begin"](dein_dir);
fn["dein#end"]();

cmd([[
filetype plugin indent on
syntax enable
]]);

if fn["dein#check_install"]() == 1 then
        fn["dein#install"]();
end
