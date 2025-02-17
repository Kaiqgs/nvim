local fn = vim.fn

return {
    options = {
        -- auto_save = true,
        -- autoformat_active = false,
        -- nonels_supress_issue58 = true,
        backup = false, -- creates a backup file
        clipboard = "unnamedplus", -- keep in sync with the system clipboard
        completeopt = "menu,menuone,noselect", -- A comma separated list of options for Insert mode completion
        conceallevel = 0, -- so that `` is visible in markdown files
        confirm = true, -- confirm to save changes before exiting modified buffer
        cursorline = true, -- highlight the current line
        dir = fn.stdpath("data") .. "/swp", -- swap file directory
        expandtab = true, -- use spaces instead of tabs
        formatoptions = "jcroqlnt", -- tcqj
        grepprg = "rg --vimgrep --smart-case --pcre2 --", -- use rg instead of grep
        hidden = true, -- Enable modified buffers in background
        history = 1000, -- Use the 'history' option to set the number of lines from command mode that are remembered.
        ignorecase = true, -- ignore case in search patterns
        inccommand = "nosplit", -- preview incremental substitute
        list = false, -- enable or disable listchars
        listchars = {
            tab = "| ",
            trail = "+",
            extends = ">",
            precedes = "<",
            space = "·",
            nbsp = "␣",
        },
        wrapscan = true, -- Searches wrap around the end of the file
        incsearch = false, -- do incremental searching
        mouse = "nv", -- enable mouse see :h mouse
        number = true, -- set numbered lines
        pumblend = 10, -- Popup blend
        pumheight = 10, -- Maximum number of entries in a popup
        relativenumber = true, -- set relative numbered lines
        scrolloff = 3, -- Minimal number of screen lines to keep above and below the cursor
        sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
        shiftround = true, -- Round indent
        shiftwidth = 4, -- the number of spaces inserted for each indentation
        showmode = false, -- we don't need to see things like -- INSERT -- anymore
        showtabline = 1, -- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
        sidescrolloff = 5, -- The minimal number of columns to scroll horizontally
        signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
        smartcase = true, -- Don't ignore case with capitals
        smartindent = true, -- Insert indents automatically
        splitbelow = true, -- force all horizontal splits to go below current window
        splitright = true, -- force all vertical splits to go to the right of current window
        swapfile = false, -- enable/disable swap file creation
        tabstop = 4, -- how many columns a tab counts for
        termguicolors = true, -- set term gui true colors (most terminals support this)
        timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)
        ttimeoutlen = 0, -- Time in milliseconds to wait for a key code sequence to complete
        undodir = fn.stdpath("data") .. "/undodir", -- set undo directory
        undofile = true, -- enable/disable undo file creation
        undolevels = 1000,
        updatetime = 300, -- faster completion
        wildignorecase = true, -- When set case is ignored when completing file names and directories
        wildmode = "longest:full,full", -- Command-line completion mode
        winminwidth = 5, -- minimum window width
        wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]],
    },

    plugins = {
        alpha = {
            -- Number of recent files shown in dashboard
            -- 0 disables showing recent files
            dashboard_recent_files = 5,
            -- disable the header of the dashboard
            disable_dashboard_header = false,
            -- disable quick links of the dashboard
            disable_dashboard_quick_links = false,
        },
        -- https://github.com/zbirenbaum/copilot.lua
        copilot = {
            enable = false,
            disable_autostart = true,
        },
        git = {
            -- which tool to use for handling git merge conflicts
            -- choose between "git-conflict" and "diffview" or "both"
            merge_conflict_tool = "git-conflict",
        },
        harpoon = {
            -- https://github.com/ThePrimeagen/harpoon
            enable = true,
            key_mappings = function(harpoon)
                -- vim.keymap.set("n")
                vim.keymap.set("n", "<leader>hcl", function()
                    harpoon:list():clear()
                end)
                vim.keymap.set("n", "<leader>a", function()
                    harpoon:list():add()
                end, { desc = "Append to harpoon" })
                vim.keymap.set("n", "<C-e>", function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end)
                vim.keymap.set("n", "<leader>1", function()
                    harpoon:list():select(1)
                end, { desc = "Harpoon 2" })
                vim.keymap.set("n", "<leader>2", function()
                    harpoon:list():select(2)
                end, { desc = "Harpoon 2" })
                vim.keymap.set("n", "<leader>3", function()
                    harpoon:list():select(3)
                end, { desc = "Harpoon 3" })
                vim.keymap.set("n", "<leader>4", function()
                    harpoon:list():select(4)
                end, { desc = "Harpoon 4" })
            end,
        },
        indent_blankline = {
            enable_scope = true,
        },
        -- https://github.com/Allaman/kustomize.nvim
        kustomize = {
            dev = false,
            opts = {
                kinds = {
                    -- setting those to false removes "clutter" but you cannot "jump" to a ressource anymore
                    show_filepath = true,
                    show_line = true,
                },
            },
        },
        lazy = {
            dev = {
                path = "$HOME/workspace/github.com/",
            },
            disable_neovim_plugins = {
                -- "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                -- "tarPlugin",
                -- "tohtml",
                -- "tutor",
                -- "zipPlugin",
            },
        },
        lualine = {
            -- https://github.com/nvim-lualine/lualine.nvim#extensions
            extensions = { "lazy" },
        },
        mini_pick = {
            mappings = {
                move_down = "<C-j>",
                move_up = "<C-k>",
            },
        },
        noice = {
            enable = false, -- Noice heavily changes the Neovim UI ...
        },
        oil = {
            --- https://github.com/stevearc/oil.nvim
            enable = true,
            key_mappings = function()
                vim.keymap.set("n", "_", "<cmd>Oil<cr>", { desc = "Open oil" })
            end,
        },
        overseer = {
            -- https://github.com/stevearc/overseer.nvim
            enable = false,
            key_mappings = function()
                vim.keymap.set(
                    "n",
                    "<leader>r",
                    "<cmd>OverseerRun<cr>",
                    { desc = "Overseer Run" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>tr",
                    "<cmd>OverseerToggle<cr>",
                    { desc = "Overseer" }
                )
            end,
        },
        spectre = {
            -- enable advanced search and replace
            -- https://github.com/nvim-pack/nvim-spectre
            enable = true,
        },
        symbol_usage = {
            enable = true,
        },
        telescope = {
            -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            -- requires cmake and gcc toolchain
            fzf_native = {
                enable = true,
            },
            -- which patterns to ignore in file switcher
            file_ignore_patterns = {
                "%.7z",
                "%.avi",
                "%.JPEG",
                "%.JPG",
                "%.V",
                "%.RAF",
                "%.burp",
                "%.bz2",
                "%.cache",
                "%.class",
                "%.dll",
                "%.docx",
                "%.dylib",
                "%.epub",
                "%.exe",
                "%.flac",
                "%.ico",
                "%.ipynb",
                "%.jar",
                "%.jpeg",
                "%.jpg",
                "%.lock",
                "%.mkv",
                "%.mov",
                "%.mp4",
                "%.otf",
                "%.pdb",
                "%.pdf",
                "%.png",
                "%.rar",
                "%.sqlite3",
                "%.svg",
                "%.tar",
                "%.tar.gz",
                "%.ttf",
                "%.webp",
                "%.zip",
                ".git/",
                ".gradle/",
                ".idea/",
                ".vale/",
                ".vscode/*",
                "__pycache__/*",
                "build/",
                -- "env/",
                "gradle/",
                "node_modules/*",
                "smalljre_*/*",
                "target/",
                "vendor/*",
            },
            -- enable greping in hidden files
            grep_hidden = true,
        },
    },

    theme = {
        -- catppuccin, nightfox, tokyonight, tundra, kanagawa
        name = "nightfox",
        catppuccin = {
            -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
            variant = "catppuccin-macchiato",
        },
        kanagawa = {
            -- kanagawa-dragon, kanagawa-lotus, kanagawa-wave
            variant = "kanagawa-wave",
        },
        nightfox = {
            -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
            variant = "carbonfox",
        },
        tokyonight = {
            -- night storm day moon
            variant = "night",
        },
    },
    -- treesitter parsers to be installed
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    treesitter_ensure_installed = {
        "go",
        "c",
        "bash",
        "cmake",
        "css",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "python",
        "regex",
        "toml",
        "yaml",
    },

    -- LSPs that should be installed by Mason-lspconfig
    lsp_servers = {
        "bashls",
        "dockerls",
        "jsonls",
        "marksman",
        "pyright",
        "lua_ls",
        "ts_ls",
        "yamlls",
        "glslls",
        "clangd",
        "gopls",
        "templ"
    },

    -- Tools that should be installed by Mason
    tools = {
        -- Formatter
        "black",
        "prettierd",
        "stylua",
        "shfmt",
        -- Linter
        "eslint_d",
        "shellcheck",
        "yamllint",
        "ruff",
        -- DAP
        "debugpy",
        "codelldb",
        "gopls",
        "gospel",
        "gotests",
        "templ"
    },
}
