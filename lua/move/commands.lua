local move_hor = require("move.core.horiz")
local move_vert = require("move.core.vert")

local M = {}

---Creates User defined commands
---@param cfg MoveConfig
M.create_user_commands = function(cfg)
  -- Line Command
  if cfg.line.enable then
    vim.api.nvim_create_user_command("MoveLine", function(args)
      if vim.bo.modifiable and not vim.bo.readonly then
        local dir = tonumber(args.args:gsub("[()]", ""), 10)
        pcall(move_vert.moveLine, dir, cfg.line.indent)
      end
    end, { desc = "Move cursor line", force = true, nargs = 1 })
  end

  -- Block Command
  if cfg.block.enable then
    vim.api.nvim_create_user_command("MoveBlock", function(args)
      if vim.bo.modifiable and not vim.bo.readonly then
        local dir = tonumber(args.args:gsub("[()]", ""), 10)
        pcall(move_vert.moveBlock, dir, args.line1, args.line2, cfg.block.indent)
      end
    end, { desc = "Move visual block", force = true, nargs = 1, range = "%" })
  end

  -- Word Command
  if cfg.word.enable then
    vim.api.nvim_create_user_command("MoveWord", function(args)
      if vim.bo.modifiable and not vim.bo.readonly then
        local dir = tonumber(args.args:gsub("[()]", ""), 10)
        pcall(move_hor.horzWord, dir)
      end
    end, { desc = "Move word forwards or backwards", force = true, nargs = 1 })
  end

  -- Character Commands
  if cfg.char.enable then
    vim.api.nvim_create_user_command("MoveHChar", function(args)
      if vim.bo.modifiable and not vim.bo.readonly then
        local dir = tonumber(args.args:gsub("[()]", ""), 10)
        pcall(move_hor.horzChar, dir)
      end
    end, { desc = "Move the character under the cursor horizontally", force = true, nargs = 1 })

    vim.api.nvim_create_user_command("MoveHBlock", function(args)
      if vim.bo.modifiable and not vim.bo.readonly then
        local dir = tonumber(args.args:gsub("[()]", ""), 10)
        pcall(move_hor.horzBlock, dir)
      end
    end, { desc = "Move visual block horizontally", force = true, nargs = 1, range = "%" })
  end
end

return M
