vim.api.nvim_create_autocmd("FileType", {
  desc = "'set errorformat for java file",
  pattern = "java",
  group = vim.api.nvim_create_augroup('java-errorformat', { clear = true }),
  callback = function()
    vim.opt_local.errorformat = '%f:%l: %t%*[^:]: %m'
  end,
})

-- local utils = require("utils")
local jdtls = require('jdtls')

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv('XDG_CACHE_HOME'),
  JDTLS_JVM_ARGS = os.getenv('JDTLS_JVM_ARGS'),
}

local function path_join(...)
    return table.concat(vim.tbl_flatten { ... }, '/')
end

local root_marker = { ".git", "mvnw", "gradlew", "pom.xml" }
local project_root_dir = require("jdtls.setup").find_root(root_marker)

local project_name     = vim.fs.basename(project_root_dir)
local cache_dir        = env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or path_join(env.HOME, '.cache')
local jdtls_cache_dir  = path_join(cache_dir, 'jdtls')
local jdtls_config_dir = path_join(jdtls_cache_dir, 'config')
local jdtls_workspace_dir    = path_join(jdtls_cache_dir, 'workspace', project_name)

local function get_jdtls_jvm_args()
    local args = {}
    for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
        local arg = string.format('--jvm-arg=%s', a)
        table.insert(args, arg)
    end
    return unpack(args)
end

local config = {
    cmd = {
        vim.fn.stdpath('config') .. '/thirdparty/jdt-language-server-1.46.1/bin/jdtls',
        '-configuration', jdtls_config_dir,
        '-data', jdtls_workspace_dir,
        get_jdtls_jvm_args(),
    },
    root_dir = project_root_dir,
}

-- local path = path_join(project_dir, ".jdtls-settings.json")
-- local settings = utils.json_decode_from_file(path)
-- if settings ~= nil then
--     config["settings"] = settings
-- end

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'java',
    group = vim.api.nvim_create_augroup('jdtls-start-or-attach', { clear = true }),
	callback = function(_)
        jdtls.start_or_attach(config)
	end,
})

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
-- settings = {
--     java = {
--         project = {
-- Package name not recognized when opening standalone java files
-- You end up with: The declared package "mypackage" does not match the expected package ""
-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/1764
--             sourcePaths = {
--                 "src"
--             }
--         }
--     }
--},

