vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
else
end
nvimtree.setup({actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  }
})

-- open nvim-tree on setup

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
