return {
  {
    "stevearc/vim-arduino",
    ft = "arduino",
    config = function()
      local function run_applescript(script)
        local tmp = os.tmpname() .. ".applescript"
        local f = io.open(tmp, "w")
        f:write(script)
        f:close()
        local result = vim.fn.system("osascript " .. tmp)
        os.remove(tmp)
        return result
      end

      local serial_pane_id = nil

      -- Kill the serial port process and close the tracked Ghostty serial pane
      local function kill_port()
        local port = vim.fn["arduino#GetPort"]()
        if port and port ~= "" then
          vim.fn.system("lsof -t " .. port .. " | xargs kill 2>/dev/null")
        end
        if serial_pane_id then
          local id = serial_pane_id
          serial_pane_id = nil
          run_applescript(string.format([[
tell application "Ghostty"
  set currentTab to selected tab of window 1
  repeat with t in terminals of currentTab
    if id of t is "%s" then
      close t
      exit repeat
    end if
  end repeat
end tell
          ]], id))
        end
      end

      -- Run a shell command in a floating terminal; auto-close on success
      local function float_upload(cmd, on_success)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.6)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
          title = " Arduino Upload ",
          title_pos = "center",
        })

        -- Close float on q or <Esc> in normal mode
        vim.keymap.set("n", "q", function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, { buffer = buf, nowait = true })
        vim.keymap.set("n", "<Esc>", function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, { buffer = buf, nowait = true })

        vim.fn.termopen(cmd, {
          on_exit = function(_, exit_code, _)
            if exit_code == 0 then
              -- Success: close float and optionally run a follow-up
              vim.schedule(function()
                if vim.api.nvim_win_is_valid(win) then
                  vim.api.nvim_win_close(win, true)
                end
                if on_success then
                  on_success()
                end
              end)
            else
              -- Failure: stay open, show hint
              vim.schedule(function()
                if vim.api.nvim_buf_is_valid(buf) then
                  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "  [Upload failed — press q to close]" })
                end
              end)
            end
          end,
        })

        vim.cmd("startinsert")
      end

      -- Keymaps for quick access
      vim.keymap.set("n", "<leader>ac", "<cmd>ArduinoVerify<CR>", { desc = "Compile Sketch" })
      vim.keymap.set("n", "<leader>au", function()
        kill_port()
        vim.fn["arduino#InitializeConfig"]()
        local cmd = vim.fn["arduino#GetCLICompileCommand"]("-u")
        float_upload(cmd)
      end, { desc = "Upload Sketch" })
      vim.keymap.set("n", "<leader>as", function()
        vim.fn["arduino#InitializeConfig"]()
        local cmd = vim.fn["arduino#GetSerialCmd"]()
        if cmd == "" then return end
        local id = run_applescript(string.format([[
tell application "Ghostty"
  set cfg to new surface configuration
  set command of cfg to "%s"
  set wait after command of cfg to true
  set currentTerminal to terminal 1 of (selected tab of window 1)
  set newPane to split currentTerminal direction down with configuration cfg
  focus currentTerminal
  return id of newPane
end tell
        ]], cmd))
        serial_pane_id = id:gsub("%s+", "")
      end, { desc = "Serial Monitor" })
      vim.keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", { desc = "Select Board" })
      vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChoosePort<CR>", { desc = "Select Port" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        arduino_language_server = {
          cmd = {
            "arduino-language-server",
            "-clangd", "/usr/bin/clangd",
            "-cli", "/opt/homebrew/bin/arduino-cli",
            "-cli-config", vim.fn.expand("~/Library/Arduino15/arduino-cli.yaml"),
          },
        },
      },
    },
  },
}
