require("rust-tools").setup({
	tools = {
		autoSetHints = false,
		hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
		debuggables = {
			use_telescope = true,
		},
		hover_actions = {
			auto_focus = true,
		},
	},
	server = {
		on_attach = require("user.lspsetup").on_attach,
		capabilities = require("user.lspsetup").capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
	},
	-- dap = {
	-- 	adapter = {
	-- 		type = "executable",
	-- 		command = "lldb-vscode",
	-- 		name = "rt_lldb",
	-- 	},
	-- },
})

