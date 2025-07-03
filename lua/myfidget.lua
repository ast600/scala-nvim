local module = {}

function module:setup()
    require("fidget").setup {
        notification = {window = {align = "top", winblend = 0}}
    }
end

return module
