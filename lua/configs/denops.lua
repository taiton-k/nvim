vim.g.denops_server_addr = "127.0.0.1:32123"

local denops_path = vim.fn["dein#get"]("denops.vim").path

vim.fn.jobstart(
        "deno run -A --no-check " .. denops_path .. "/denops/@denops-private/cli.ts",
        {detach = true}
)
