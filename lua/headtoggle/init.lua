local M = {}
M.switch_file = function(split)
	-- local file_name = vim.fn.expand("%:t")
	-- local file_type = vim.bo.filetype
	local file_name_no_ext = vim.fn.expand("%:r")
	local file_ext = vim.fn.expand("%:e")
	local target
	if file_ext == "h" then
		target = file_name_no_ext .. ".cpp"
	elseif file_ext == "cpp" then
		target = file_name_no_ext .. ".h"
	else
		vim.notify("not a h/cpp file", vim.diagnostic.severity.WARN)
		return
	end
	if split == "v" then
		vim.cmd("vsplit " .. target)
	elseif split == "h" then
		vim.cmd("split " .. target)
	else
		vim.cmd("edit " .. target)
	end
end

M.setup = function()
	print("headtoggle")
	vim.notify("hiiiiii", vim.diagnostic.severity.ERROR)
	vim.keymap.set("n", "<leader>cT", function()
		require("headtoggle").switch_file()
	end, { desc = "code [T]oggle .h/.cpp" })
	vim.keymap.set("n", "<leader>cV", function()
		require("headtoggle").switch_file("v")
	end, { desc = "code open .h/.cpp vertical split" })
	vim.keymap.set("n", "<leader>cv", function()
		require("headtoggle").switch_file("h")
	end, { desc = "code open .h/.cpp horizontal spli" })
end

return M
