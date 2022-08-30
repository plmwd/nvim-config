local git = {}

local context = {}

local function extend_opts(cmd, opts, args)
  for key, val in pairs(args) do
    if opts[key] then
      vim.list_extend(cmd, vim.is_callable(val) and args[key](opts[key]) or { val })
    end
  end
end

local function apply_context(opts)
  return vim.tbl_extend('force', opts, context)
end

local function git_do(subcmd, opts, args)
  if not git.is_installed() then
    return
  end

  opts = opts or {}
  opts = apply_context(opts)
  local cmd = { 'git', subcmd }
  extend_opts(cmd, opts, args)
  local job_id = opts and vim.fn.jobstart(cmd, opts) or vim.fn.jobstart(cmd)
  return vim.fn.jobwait({ job_id })[1] == 0
end

local function defer_join(flag)
  return function(opt)
    return { flag, opt }
  end
end

function git.is_installed()
  return true
end

function git.context(opts, work)
  context = opts
  work()
  context = {}
end

function git.commit(opts)
  if not git_do('commit', opts, {
    mes = defer_join('-m'),
    all = '-a',
  }) then
    return false
  end
  return true
end

function git.push(opts)
  if not git_do('push', opts, {}) then
    return false
  end
  return true
end

function git.pull(opts)
  if git_do('pull', opts, {
    rebase = '-r'
  }) then
    return true
  end
  return false
end

return git
