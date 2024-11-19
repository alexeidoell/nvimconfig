return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		opts = {},
		dependencies = 
		{
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
		}
	},
    {
	    "nvim-treesitter/nvim-treesitter",
	    config = function()
		    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		    ts_update()
	    end,
    },
}
