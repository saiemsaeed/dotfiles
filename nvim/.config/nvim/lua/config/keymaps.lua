-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Add any additional keymaps here
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<cmd>update<CR>", { silent = true, noremap = true })

-- -- Move to the beginning and end of a line in normal mode
-- vim.keymap.set({ "n" }, "<C-;>", "<cmd>cnext<CR>zz", {})
-- vim.keymap.set({ "n" }, "<C-,>", "<cmd>cprev<CR>zz", {})

-- Move selected line / block of text in visual mode up and down
vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv", {})

-- Center the cursor when searching
vim.keymap.set({ "n" }, "n", "nzzzv", {})
vim.keymap.set({ "n" }, "N", "Nzzzv", {})

-- Copy to system clipboard
vim.keymap.set({ "n" }, "<leader>y", '"+y', {})
vim.keymap.set({ "v" }, "<leader>y", '"+y', {})
vim.keymap.set({ "n" }, "<leader>Y", '"+Y', {})

-- Yank without changing the clipboard
vim.keymap.set("x", "p", "P", { noremap = true })
vim.keymap.set("x", "P", "p", { noremap = true })

-- delete without yanking to register
vim.keymap.set({ "n" }, "d", '"_d', {})
vim.keymap.set({ "v" }, "d", '"_d', {})

-- Splitting Windows
vim.keymap.set({ "n" }, "<leader>/", "<cmd>vsplit<CR>", {})
vim.keymap.set({ "n" }, "<leader>-", "<cmd>split<CR>", {})

vim.keymap.set({ "n" }, "<leader>q", "<cmd>bd<CR>", {})
vim.keymap.set({ "n" }, "<leader>Q", "<cmd>q<CR>", {})
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<cmd>wa<CR>", {})

-- Select All Text in Buffer
vim.keymap.set("n", "<D-a>", "ggVG", { noremap = true, desc = "Select all text in buffer" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>tw",
  "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
  {}
)

vim.keymap.set("n", "<c-/>", function()
  Snacks.terminal(nil, {
    cwd = LazyVim.root(),
    win = {
      width = 0.25,
      height = 0.5,
      position = "right",
    },
  })
end, { desc = "Terminal (Root Dir)" })

vim.keymap.set("i", "jk", "<esc>", { noremap = true, desc = "Select all text in buffer" })

local function github_browse_line(opts)
  opts = opts or {}

  local root = LazyVim.root.git()
  if not root or root == "" then
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return
  end

  local abs = vim.api.nvim_buf_get_name(0)
  if abs == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return
  end

  local rel = vim.fs.relpath(root, abs) or vim.fn.fnamemodify(abs, ":t")
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local function system_text(args)
    local res = vim.system(args, { cwd = root, text = true }):wait()
    if res.code ~= 0 then
      return ""
    end
    return vim.trim(res.stdout or "")
  end

  local ref = opts.ref
  if not ref or ref == "" then
    -- Prefer the upstream branch (a GitHub ref) when available.
    -- A purely local branch name may not exist on GitHub yet.
    local upstream = system_text({ "git", "rev-parse", "--abbrev-ref", "@{u}" })
    if upstream ~= "" then
      ref = upstream:gsub("^[^/]+/", "")
    else
      ref = system_text({ "git", "branch", "--show-current" })
      if ref == "" then
        ref = system_text({ "git", "rev-parse", "HEAD" })
      end
    end
  end

  local target = rel .. ":" .. line

  local function run_gh(args, on_done)
    vim.system(args, { cwd = root, text = true }, function(obj)
      if on_done then
        on_done(obj)
      end
    end)
  end

  local args = { "gh", "browse" }
  if ref ~= "" then
    vim.list_extend(args, { "--branch", ref })
  end
  table.insert(args, target)

  run_gh(args, function(obj)
    if obj.code == 0 then
      return
    end

    local stderr = vim.trim(obj.stderr or "")
    if ref ~= "" and stderr:find("Cannot find a valid ref", 1, true) then
      vim.schedule(function()
        vim.notify(
          "Branch ref not found on GitHub. Push it (git push -u origin "
            .. ref
            .. ") or use gO for main.",
          vim.log.levels.WARN
        )
      end)
      return
    end

    local msg = stderr ~= "" and stderr or "Failed to run gh browse"
    vim.schedule(function()
      vim.notify(msg, vim.log.levels.ERROR)
    end)
  end)
end

-- GitHub browse current line
-- NOTE: LazyVim already provides <leader>gB (open) and <leader>gY (copy) via Snacks.gitbrowse().
vim.keymap.set("n", "go", function()
  github_browse_line()
end, { desc = "GitHub Browse (current branch)" })

vim.keymap.set("n", "gO", function()
  github_browse_line({ ref = "main" })
end, { desc = "GitHub Browse (main)" })

vim.keymap.set("n", "gC", function()
  local root = LazyVim.root.git()
  if not root or root == "" then
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return
  end

  local abs = vim.api.nvim_buf_get_name(0)
  if abs == "" then
    vim.notify("No file name for current buffer", vim.log.levels.WARN)
    return
  end

  local rel = vim.fs.relpath(root, abs) or vim.fn.fnamemodify(abs, ":t")
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local res = vim.system({ "git", "rev-parse", "HEAD" }, { cwd = root, text = true }):wait()
  local sha = res.code == 0 and vim.trim(res.stdout or "") or ""
  if sha == "" then
    vim.notify("Failed to detect current commit", vim.log.levels.ERROR)
    return
  end

  -- NOTE: gh's --commit flag takes an optional value, so we must pass it as --commit=<sha>
  -- otherwise the SHA may be parsed as a second positional argument.
  vim.system({ "gh", "browse", rel .. ":" .. line, "--commit=" .. sha }, { cwd = root, text = true }, function(obj)
    if obj.code ~= 0 then
      local msg = vim.trim(obj.stderr or "")
      vim.schedule(function()
        vim.notify(msg ~= "" and msg or "Failed to run gh browse", vim.log.levels.ERROR)
      end)
    end
  end)
end, { desc = "GitHub Browse (commit)" })
