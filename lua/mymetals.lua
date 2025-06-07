module = {}

function module:setup()
	metals_config = require('metals').bare_config()
	metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
	metals_config.capabilities.textDocument.completion.completionItem.snippetSupport = false
	metals_config.init_options.statusBarProvider = "off"
	metals_config.on_attach = require('metals').setup_dap

	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt", "java" },
		callback = function()
			require("metals").initialize_or_attach(metals_config)
		end,
		group = nvim_metals_group,
	})

	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = { '*.scala' },
		group = nvim_metals_group,
		callback = function(args)
			local client = vim.lsp.get_clients({ bufnr = args.buf, name = "metals" })[1]
			if client ~= nil then
				vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
			end
		end
	})

	vim.keymap.set("n", "gD",  vim.lsp.buf.definition)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
	vim.keymap.set("n", "gr", vim.lsp.buf.references)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
	vim.keymap.set("n", "<leader>bd", vim.diagnostic.setloclist)
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover)
end

return module
