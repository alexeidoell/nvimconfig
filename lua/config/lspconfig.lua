vim.lsp.config('clangd', {
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
    init_options = {
        fallbackFlags = { 'I.', '-Wall', '-pedantic' }
    },
})
