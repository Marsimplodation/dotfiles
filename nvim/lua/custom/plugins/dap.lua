vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

return {
  "mfussenegger/nvim-dap",

  dependencies = {

    { "nvim-neotest/nvim-nio" },
    { "Jorenar/nvim-dap-disasm" },

    -- fancy UI for the debugger
    {
      "igorlfs/nvim-dap-view",
      opts = {
        winbar = {
          show = true,
          -- You can add a "console" section to merge the terminal with the other views
          sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "disassembly" },
          default_section = "repl",

          controls = {
            enabled = true,
            position = "right",
            buttons = {
              "play",
              "step_into",
              "step_over",
              "step_out",
              "step_back",
              "run_last",
              "terminate",
              "disconnect",
            },
            custom_buttons = {},
          },

        },
        icons = {
          collapsed = "󰅂 ",
          disabled = "",
          disconnect = "",
          enabled = "",
          expanded = "󰅀 ",
          filter = "󰈲",
          negate = " ",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = "",
        },
        render = {
          -- Optionally a function that takes two `dap.Variable`'s as arguments
          -- and is forwarded to a `table.sort` when rendering variables in the scopes view
          sort_variables = nil,
          -- Full control of how frames are rendered, see the "Custom Formatting" page
          threads = {
            -- Choose which items to display and how
            format = function(name, lnum, path)
              return {
                { part = name, separator = " " },
                { part = path, hl = "FileName",  separator = ":" },
                { part = lnum, hl = "LineNumber" },
              }
            end,
            -- Align columns
            align = false,
          },
          -- Full control of how breakpoints are rendered, see the "Custom Formatting" page
          breakpoints = {
            -- Choose which items to display and how
            format = function(line, lnum, path)
              return {
                { part = path, hl = "FileName" },
                { part = lnum, hl = "LineNumber" },
                { part = line, hl = true },
              }
            end,
            -- Align columns
            align = false,
          },
        },
        -- Requires neovim 0.12+
        virtual_text = {
          -- Control with `DapViewVirtualTextToggle`
          enabled = true,
          -- Supported options include "inline", "eol", and "eol_right_align"
          position = "inline",
          format = function(variable, _, _)
            return " " .. variable.value
          end,
          -- Prepend the variable name (when using eol positioning)
          prefix = function(position, node, bufnr)
            if position == "eol" or position == "eol_right_align" then
              local name = vim.treesitter.get_node_text(node, bufnr)

              return name .. " ="
            end
          end,
          -- Add commas between variables (when using eol positioning)
          suffix = function(position, _, _, var_index, num_var_line)
            if position == "eol" or position == "eol_right_align" then
              return var_index == num_var_line and "" or ","
            end
          end,
        },
        -- Controls how to jump when selecting a breakpoint or navigating the stack
        -- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
        -- Only a subset of the options is available: newtab, useopen, usetab and uselast
        -- Can also be a function that takes the current winnr and the destination bufnr
        -- If a function, should return the winnr of the destination window
        switchbuf = "usetab,uselast",
        -- Auto open when a session is started and auto close when all sessions finish
        -- Alternatively, can be a string:
        -- - "keep_terminal": as above, but keeps the terminal when the session finishes
        -- - "open_term": open the terminal when starting a new session, nothing else
        auto_toggle = false,
        -- Reopen dapview when switching to a different tab
        -- Can also be a function to dynamically choose when to follow, by returning a boolean
        -- If a function, receives the name of the adapter for the current session as an argument
        follow_tab = false,
      },
      keys = {
        {
          "<leader>du",
          function()
            require("dap-view").toggle()
          end,
          desc = "DAP View",
        },
      },
    },


    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
        },
      },
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
    { "<leader>da", function() require("dap").continue() end,                                             desc = "Run" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", {
      bg = "#2a2a2a",
    })

    vim.api.nvim_set_hl(0, "DapStoppedLine", {
      bg = "#313244",
    })

    vim.fn.sign_define("DapBreakpoint", {
      text = " ",
      texthl = "DiagnosticError",
    })

    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DiagnosticWarn",
      linehl = "DapStoppedLine",
    })
    require("dap-disasm").setup({
      dapview_register = true,

      dapview = {
        keymap = "D",
        label = "Disassembly",
        short_label = "",
      },

      winbar = {
        enabled = true,
        labels = {
          step_into = "Step Into",
          step_over = "Step Over",
          step_back = "Step Back",
        },
        order = {
          "step_into",
          "step_over",
          "step_back",
        },
      },

      sign = "DapStopped",

      ins_before_memref = 16,
      ins_after_memref = 16,

      columns = {
        "address",
        "instructionBytes",
        "instruction",
      },
    })
  end,
}
