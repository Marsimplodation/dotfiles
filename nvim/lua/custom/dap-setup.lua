local dap = require('dap')

local function pick_cwd()
  local input = vim.fn.input("Working dir (blank = cwd): ", vim.fn.getcwd(), "dir")
  if input == "" then
    return vim.fn.getcwd()
  end
  return input
end

local function pick_args()
  local input = vim.fn.input("Args: ")
  if input == "" then
    return {}
  end
  return vim.split(input, " ")
end

local function pick_program(default)
  return function()
    return vim.fn.input("Path: ", default or vim.fn.getcwd() .. "/", "file")
  end
end
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    name = "Launch file",
    type = "python",
    request = "launch",

    program = "${file}",
    cwd = function()
      return pick_cwd()
    end,

    args = function()
      return pick_args()
    end,

    pythonPath = function()
      return vim.fn.exepath("python")
    end,
  },

  {
    name = "Attach (debugpy)",
    type = "python",
    request = "attach",
    connect = {
      host = "127.0.0.1",
      port = 5678,
    },
  },
}

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap" },
}

dap.configurations.cpp = {
  {
    name = "Launch (GDB)",
    type = "gdb",
    request = "launch",

    program = pick_program(),

    cwd = function()
      return pick_cwd()
    end,

    args = function()
      return pick_args()
    end,

    stopAtEntry = true,
  },
}


