local M = {}

function M.config()
    require('kommentary.config').configure_language('default', {
        prefer_single_line_comments = true,
    })
end

return M
