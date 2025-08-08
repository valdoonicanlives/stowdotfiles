local M = {}

-- Simple password-to-seed hash function
local function hash_password(pw)
  local hash = 0
  for i = 1, #pw do
    hash = (hash * 31 + pw:byte(i)) % 1000000007
  end
  return hash
end

-- Generate mapping based on password-derived seed
local function generate_mapping(password)
  local seed = hash_password(password)
  math.randomseed(seed)
  local charset = {}
  for i = 32, 126 do table.insert(charset, string.char(i)) end
  local unpack = unpack or table.unpack
  local shuffled = { unpack(charset) }
  for i = #shuffled, 2, -1 do
    local j = math.random(i)
    shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
  end
  local map, reverse = {}, {}
  for i, c in ipairs(charset) do
    map[c] = shuffled[i]
    reverse[shuffled[i]] = c
  end
  return map, reverse
end

-- Transform text
local function transform_text(text, map)
  local result = {}
  for i = 1, #text do
    local c = text:sub(i, i)
    table.insert(result, map[c] or c)
  end
  return table.concat(result)
end

-- Apply transformation to selected or full range
local function transform_lines(start_line, end_line, map)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  for i, line in ipairs(lines) do
    lines[i] = transform_text(line, map)
  end
  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, lines)
end

-- Ask user for a password
local function get_password()
  local input = vim.fn.inputsecret("Enter password: ")
  vim.cmd("redraw")  -- clean up input line
  return input
end

-- Command handlers
function M.scramble_cmd(opts)
  local password = get_password()
  if password == "" then
    vim.notify("Scramble cancelled: no password entered.", vim.log.levels.WARN)
    return
  end
  local map, _ = generate_mapping(password)
  local start_line = (opts.line1 or 1) - 1
  local end_line = opts.line2 or -1
  transform_lines(start_line, end_line, map)
end

function M.unscramble_cmd(opts)
  local password = get_password()
  if password == "" then
    vim.notify("Unscramble cancelled: no password entered.", vim.log.levels.WARN)
    return
  end
  local _, reverse = generate_mapping(password)
  local start_line = (opts.line1 or 1) - 1
  local end_line = opts.line2 or -1
  transform_lines(start_line, end_line, reverse)
end

-- Setup command
function M.setup()
  vim.api.nvim_create_user_command("Scramble", M.scramble_cmd, { range = "%" })
  vim.api.nvim_create_user_command("Unscramble", M.unscramble_cmd, { range = "%" })
end

return M
