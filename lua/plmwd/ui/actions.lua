local action_state = require 'telescope.actions.state'
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

local plmwd_actions = {}

function plmwd_actions.goto_parent_dir(prompt_bufnr)
  actions.close(prompt_bufnr)
  vim.cmd [[ cd .. ]]
  builtin.find_files()
end

return plmwd_actions
