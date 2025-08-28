local pets = {
  cats = {
  {
  [[              ＿＿]],
  [[　　　　　🌸＞　　 フ ]],
  [[　　　　　| 　_　 _|]],
  [[　 　　　／` ミ_wノ]],
  [[　　 　 /　　　 　 |]],
  [[　　　 /　 ヽ　　 ﾉ]],
  [[　 　 │　　|　|　|]],
  [[　／￣|　　 |　|　|]],
  [[　| (￣ヽ＿_ヽ_)__)]],
  [[　＼二つ]]
  },
  {
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢀⡴⣆⠀⠀⠀⠀⠀⣠⡀ ᶻ 𝗓 𐰁 .ᐟ ⣼⣿⡗⠀⠀⠀⠀]],
  [[⠀⠀⠀⣠⠟⠀⠘⠷⠶⠶⠶⠾⠉⢳⡄⠀⠀⠀⠀⠀⣧⣿⠀⠀⠀⠀⠀]],
  [[⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣤⣤⣤⣤⣤⣿⢿⣄⠀⠀⠀⠀]],
  [[⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠙⣷⡴⠶⣦]],
  [[⠀⠀⢱⡀⠀⠉⠉⠀⠀⠀⠀⠛⠃⠀⢠⡟⠀⠀⠀⢀⣀⣠⣤⠿⠞⠛⠋]],
  [[⣠⠾⠋⠙⣶⣤⣤⣤⣤⣤⣀⣠⣤⣾⣿⠴⠶⠚⠋⠉⠁⠀⠀⠀⠀⠀⠀]],
  [[⠛⠒⠛⠉⠉⠀⠀⠀⣴⠟⢃⡴⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]
  }
}
}

local pet_win = nil
local pet_buf = nil
local current_pet = 1

local function strwidth(s)
  return vim.fn.strdisplaywidth(s)
end

local function create_pet(pet_art)
  if pet_win and vim.api.nvim_win_is_valid(pet_win) then
    vim.api.nvim_win_close(pet_win, true)
  end
  pet_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(pet_buf, 0, -1, false, pet_art)

  local ui = vim.api.nvim_list_uis()[1]
  local width, height = 0, #pet_art

  for _, line in ipairs(pet_art) do
    width = math.max(width, strwidth(line))
  end

pet_win = vim.api.nvim_open_win(pet_buf, false, {
  relative = "editor",
  width = width,
  height = height,
  row = ui.height - height - 2,
  col = ui.width - width,
  style = "minimal",
  border = "none",
  noautocmd = true,
})

  -- Make floating window inherit from Normal, not NormalFloat
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

end

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    create_pet(pets.cats[current_pet])
  end,
})

--- Cycle pets
local function show_next_pet()
  create_pet(pets.cats[current_pet])
  current_pet = (current_pet % #pets.cats) + 1  -- increment mod size
end

vim.api.nvim_create_user_command("CyclePets", show_next_pet, {})
show_next_pet()
