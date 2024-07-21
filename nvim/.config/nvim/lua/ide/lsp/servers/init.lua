local M = {}

-- list of servers that I always want installed
M.default_servers = {
	"html",
	"cssls",
	"tsserver",
	"svelte",
	"lua_ls",
	"jsonls",
	"emmet_ls",
	"angularls",
}

local server_settings = {
	emmet_ls = require("ide.lsp.servers.emmet_ls"),
	lua_ls = require("ide.lsp.servers.lua_lsp"),
	jsonls = require("ide.lsp.servers.jsonls"),
	tsserver = require("ide.lsp.servers.tsserver"),
	angularls = require("ide.lsp.servers.angularls"),
	angularGoTo = require("ide.lsp.servers.angularGoTo"),
}

-- easily disable lsps in .neoconf.json like this
-- {
-- "tsserver": { "disable": true }
-- }
M.is_disabled = function(client)
	return require("neoconf").get(client .. ".disable")
end

local get_server_settings = function(server_name)
	-- return standard server settings in all other cases
	return server_settings[server_name] or {}
end

-- server_settings.setup()
M.setup = function()
	local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lsp_attach = function(_, _)
		-- helper
		local surround_helper = function(cmd)
			return string.format("<cmd>lua vim.lsp.%s<cr>", cmd)
		end
		vim.keymap.set("n", "K", surround_helper("buf.hover()"))
		vim.keymap.set("n", "gD", surround_helper("buf.declaration()"))
		vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "gi", surround_helper("buf.implementation()"))
		vim.keymap.set("n", "s", surround_helper("buf.rename()"))
		vim.keymap.set("n", "ga", surround_helper("buf.code_action()"))
		vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		vim.keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		vim.keymap.set("n", "<space>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		vim.keymap.set("n", "<space>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		vim.keymap.set("n", "<space>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		vim.keymap.set("n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		vim.keymap.set("n", "<space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.keymap.set("n", "<space>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
		vim.keymap.set("n", "<space>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		vim.keymap.set("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
		vim.keymap.set("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
		vim.keymap.set("n", "<space>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
		vim.keymap.set("n", "<space>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end

	M.get_config = function(server_name)
		return vim.tbl_extend("keep", get_server_settings(server_name), {
			on_attach = lsp_attach,
			capabilities = default_capabilities,
		})
	end
end

return M
