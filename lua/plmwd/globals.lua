function _G.iprint(...)
  print(vim.inspect(...))
end

-- TODO: add some kind of error reporting
function _G.safe_setup(plugin_name, opts_or_fun)
  local plugin_present, plugin = pcall(require, plugin_name)
  if plugin_present then
    if vim.is_callable(opts_or_fun) then
      opts_or_fun(plugin)
    elseif opts_or_fun then
      plugin.setup(opts_or_fun)
    else
      plugin.setup()
    end
  end

  return {
    next = function(next_plugin_name, next_opts_or_fun)
      if plugin_present then
        return _G.safe_setup(next_plugin_name, next_opts_or_fun)
      end
    end
  }
end
