local json = require("json")

local M = {}

function M.split(str, sep)
   local result = {}
   local regex = ("([^%s]+)"):format(sep)
   for each in str:gmatch(regex) do
      table.insert(result, each)
   end
   return result
end

-- see if the file exists
function M.file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function M.lines_from(file)
  if not M.file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end


function M.read_file(path)
    -- r read mode and b binary mode
    local file = io.open(path, "rb")
    if not file then return nil end
    -- *a or *all reads the whole file
    local content = file:read("*a")
    file:close()
    return content
end

function M.json_decode_from_file(path)
    local content = M.read_file(path)
    if content == nil then return nil end
    return json.decode(content)
end

function M.json_encode_into_file(path, data, prettier)
    local out = io.open(path, 'w')
    if prettier == nil then prettier = false end
    out:write(json.encode(data, prettier))
    io.close(out)
end


return M
