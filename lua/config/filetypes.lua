vim.filetype.add({
    extension = { gotmpl = "gotmpl" },
    pattern = {
        [".*/templates/.*%.tmpl"] = "gotmpl",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
        [".*/views/.*%.tmpl$"] = "gotmpl",
        [".*/views/.*%.tmpl"] = "htmldjango",
    },
})
