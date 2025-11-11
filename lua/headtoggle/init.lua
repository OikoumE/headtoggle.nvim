local M = {}
M.file_exsist = function(target)
	local exsist = vim.fn.filereadable(target) == 1
	return exsist
end

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
	if M.file_exsist(target) then
		if split == "v" then
			vim.cmd("vsplit " .. target)
		elseif split == "h" then
			vim.cmd("split " .. target)
		else
			vim.cmd("edit " .. target)
		end
	else
		if file_ext == "h" then
			vim.notify("no .cpp file found for: " .. file_name_no_ext)
		elseif file_ext == "cpp" then
			vim.notify("no .h file found for: " .. file_name_no_ext)
		end
	end
end

M.setup = function()
	vim.keymap.set("n", "<leader>cT", function()
		require("headtoggle").switch_file()
	end, { desc = "code [T]oggle .h/.cpp" })
	vim.keymap.set("n", "<leader>cv", function()
		require("headtoggle").switch_file("v")
	end, { desc = "code open .h/.cpp vertical split" })
	vim.keymap.set("n", "<leader>cV", function()
		require("headtoggle").switch_file("h")
	end, { desc = "code open .h/.cpp horizontal spli" })
end

return M
