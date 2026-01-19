return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
        -- inspired by https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua 

        local lualine = require('lualine')
        local palette = require("yorumi.colors")

        local checks = {
            empty_buffer = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            oil = function()
                return vim.bo.filetype == 'oil'
            end,
            dashboard = function()
                return vim.bo.filetype == 'snacks_dashboard'
            end,
            disabled_ft = function()
                return vim.bo.filetype ~= 'snacks_dashboard' and vim.bo.filetype ~= 'oil'
            end,
            is_git_workspace = function()
                local handle = io.popen("git rev-parse --is-inside-work-tree 2> /dev/null")
                if not handle then
                    print("couldn't execute git rev-parse")
                    return false
                end
                local result = handle:read("*a")
                handle:close()

                return result:match("true") ~= nil
            end,
        }

        -- config here 
        local cfg = {
            icons_enabled = false,
            globalstatus = true,
            options = {
                component_separators = '',
                section_separators = '',

                theme = {
                    normal = { c = { fg = palette.tsuki3, bg = palette.yoru0 }},
                    inactive = { c = { fg = palette.tsuki1, bg = palette.yoru0 }},
                },
            },

            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            extensions = {
                "lazy",
            },
        }
        local mode_map = {
            ['NORMAL'] = 'N',
            ['O-PENDING'] = 'N?',
            ['INSERT'] = 'I',
            ['VISUAL'] = 'V',
            ['V-BLOCK'] = 'VB',
            ['V-LINE'] = 'VL',
            ['V-REPLACE'] = 'VR',
            ['REPLACE'] = 'R',
            ['COMMAND'] = '!',
            ['SHELL'] = 'SH',
            ['TERMINAL'] = 'T',
            ['EX'] = 'X',
            ['S-BLOCK'] = 'SB',
            ['S-LINE'] = 'SL',
            ['SELECT'] = 'S',
            ['CONFIRM'] = 'Y?',
            ['MORE'] = 'M',
        }

        local function insert_left(component)
            table.insert(cfg.sections.lualine_c, component)
        end

        local function insert_right(component)
            table.insert(cfg.sections.lualine_x, component)
        end

        -- active bar
        --[[
        insert_left {
            function()
                return ''
            end,
            color = { fg = palette.tsuki4 }, -- Sets highlighting of component
            padding = { left = 0, right = 0 }, -- We don't need space before this
        }
        ]]

        insert_left {
            'mode',
            fmt = function(s) return mode_map[s] or s end,
            gui='bold',
            color = function()
                local mode_color = {
                    n = palette.sangoCyan,
                    i = palette.sangoGreen,
                    v = palette.sangoYellow,
                    [' '] = palette.sangoBlue,
                    V = palette.kairoYellow,
                    c = palette.sangoCyan,
                    R = palette.kairoRed,
                }
                return { fg = mode_color[vim.fn.mode()] , gui = "bold", }
            end,
            cond = function() return not checks.dashboard() end,
            padding = { left = 1, right = 0 },
        }


        insert_left {
            'filename',
            cond = checks.empty_buffer,
            color = { fg = palette.sangoCyan, gui = 'bold'}
        }

        insert_left {
            function()
                return vim.fn.getcwd()
            end,
            fmt = function(str)
                return str:gsub(vim.env.HOME, "~")
            end,
            cond = checks.dashboard,
            color = { fg = palette.sangoCyan, gui = 'bold'}
        }

        insert_left {
            function()
                return require("oil").get_current_dir()
            end,
            fmt = function(str)
                return str:gsub(vim.env.HOME, "~")
            end,
            cond = checks.oil,
            color = { fg = palette.sangoCyan, gui = 'bold'}
        }

        --[[
        insert_left {
            'filesize',
            cond = checks.empty_buffer,
        }

        insert_left {
            'location'
        }

        insert_left {
            'progress',
            color = { fg = palette.sangoBlue, gui = 'bold' }
        }

        insert_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = palette.sangoRed },
                color_warn  = { fg = palette.sangoYellow },
                color_info  = { fg = palette.sangoCyan },
            },
        }
        ]]
        --[[
        insert_right {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added     = { fg = palette.kairoGreen },
                modified  = { fg = palette.kairoYellow },
                removed   = { fg = palette.kairoRed },
            },
        }
        insert_right {
            'filetype',
            cond = checks.disabled_ft,
            color = { bg = palette.kuroiBlue }
        }

        insert_right {
            function()
                local msg = ''
                local buf_ft = vim.bo.filetype
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = '',
            padding = { left = 0, right = 1 },
            color = { bg = palette.kuroiBlue }
        }
        ]]

        insert_right {
            'lsp_status',
            icon = '', -- f013
            symbols = {
                -- Standard unicode symbols to cycle through for LSP progress:
                spinner = {},
                -- Standard unicode symbol for when LSP is done:
                done = '',
                -- Delimiter inserted between LSP names:
                separator = '',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            padding = {left = 0, right = 0},
            color = { fg = palette.sangoGreen, gui = 'bold' },
        }


        insert_right {
            'branch',
            icon = '',
            color = { fg = palette.sangoViolet, gui = 'bold' },
        }

   
        lualine.setup(cfg)
    end,
}
