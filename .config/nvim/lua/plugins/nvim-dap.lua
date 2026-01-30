return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
        -- Zamknij dap ui na zakończenie debugowania
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })

      -- === C# / .NET CORE DEBUGGER (POPRAWIONY) ===
      dap.adapters.coreclr = function(callback, config)
        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"

        -- Sprawdź czy plik istnieje
        if not vim.fn.filereadable(mason_path) then
          vim.notify("ERROR: netcoredbg NOT FOUND: " .. mason_path, vim.log.levels.ERROR)
          return
        end

        callback({
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = mason_path,
            args = {
              "--interpreter=vscode",
              "--protocolLogger", "/tmp/netcoredbg.log"
            },
          }
        })
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch (.NET Core) - wybierz DLL",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Ścieżka do .dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
          end,
          args = {},
          stopAtEntry = false,
          console = "internalConsole",
        },
        {
          type = "coreclr",
          name = "Attach do procesu",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
        {
          type = "coreclr",
          name = "dotnet run (automatycznie)",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = function()
            -- Automatycznie znajdź DLL po dotnet build
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return vim.fn.getcwd() .. "/bin/Debug/net8.0/" .. project_name .. ".dll"
          end,
          preLaunchTask = "build",
          console = "internalConsole",
        },
      }

      -- === TWOJE ORYGINALNE CONFIGURACJE (bez zmian) ===
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          args = {},
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          pid = function()
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- DapUI setup
      require("dapui").setup()
    end,
  },
}
