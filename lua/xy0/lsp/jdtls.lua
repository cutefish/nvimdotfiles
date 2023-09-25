local M = {}
local util = require("xy0.util")

--------------------------------------------------------------------------------
-- Attach set up
--------------------------------------------------------------------------------
local jdtls = require('jdtls')
local lspstatus = require('lsp-status')
local lsputil = require('xy0.lsp.util')
local on_attach = function(client, bufnr)
    -- attach lsp-status
    lspstatus.on_attach(client)
    -- common on attach
    lsputil.on_attach(bufnr)
    -- setup dap
    jdtls.setup_dap()
    -- more java specific mappings
    local function buf_set_keymap(mode, lhs, rhs, opts)
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<space>i", jdtls.organize_imports, opts)
    buf_set_keymap("n", "<space>tc", jdtls.test_class, opts)
    buf_set_keymap("n", "<space>tm", jdtls.test_nearest_method, opts)
    buf_set_keymap(
        "v", "<space>ev",
        "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    buf_set_keymap("n", "<space>ev", jdtls.extract_variable, opts)
    buf_set_keymap(
        "v", "<space>em",
        "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end

--------------------------------------------------------------------------------
-- JDTLS server setup
--------------------------------------------------------------------------------
-- base config
local install_dir = '/scratch/install/jdtls/'
local config_dir = install_dir .. 'config_linux'
local workspace_dir = '/scratch/data/jdtls/ws/' .. util.get_project_name()
local config = {
    -- The command that starts the language server
    -- See:
    -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        -- '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar',
        vim.fn.glob(
            install_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", true),

        '-configuration', config_dir,

        '-data', workspace_dir
    },

    root_dir = util.get_root(),
}

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
config.settings = {
    java = {
        codeGeneration = {
            toString = {
                template =
                    '${object.className}{${member.name()}' ..
                    '=${member.value}, ${otherMembers}}'
            }
        },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.Assert.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*"
            },
            importOrder = {
                "#",
                "java",
                "javax",
                "oracle",
                "org",
                "com",
            },
        },
        configuration = {
            runtimes = {
                {
                    name = "JavaSE-11",
                    path = "/scratch/install/jdk11",
                },
                {
                    name = "JavaSE-17",
                    path = "/scratch/install/jdk17",
                },
            }
        },
        contentProvider = { preferred = "fernflower" },
        eclipse = {
            downloadSources = true,
        },
        format = {
            settings = {
                url = '/scratch/data/jdtls/eclipse-style.xml',
                profile = 'GoogleStyle'
            }
        },
        flags = {
            allow_incremental_sync = false,
            server_side_fuzzy_completion = true,
        },
        implementationsCodeLens = {
            enabled = false, --Don"t automatically show implementations
        },
        inlayHints = {
            parameterNames = { enabled = "literals" },
        },
        import = {
            gradle = { enabled = false },
        },
        maven = {
            downloadSources = true,
        },
        referencesCodeLens = {
            enabled = false, --Don"t automatically show references
        },
        references = {
            includeDecompiledSources = true,
        },
        saveActions = {
            organizeImports = false,
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        signatureHelp = { enabled = true },
    }
}

config.on_attach = on_attach

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
function M.setup()
    vim.api.nvim_create_autocmd("Filetype", {
        pattern = "java", -- autocmd to start jdtls
        callback = function()
            require("jdtls").start_or_attach(config)
        end,
    })
end

return M
