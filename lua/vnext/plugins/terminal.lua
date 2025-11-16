-- Keymap для выхода из терминала в нормальный режим
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { noremap = true })

-- Состояние для плавающего терминала
local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

-- Функция создания плавающего окна
local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }
    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

-- Функция переключения терминала
local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window()
        vim.fn.termopen(vim.o.shell)
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
    vim.api.nvim_command("startinsert")
end

-- Команда и маппинг для вызова терминала
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>t", toggle_terminal, { desc = "Toggle Floaterminal" })

