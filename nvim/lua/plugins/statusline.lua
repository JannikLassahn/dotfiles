vim.cmd [[packadd nvim-web-devicons]]
local gl = require 'galaxyline'
local condition = require 'galaxyline.condition'
local diagnostic = require 'galaxyline.provider_diagnostic'

local gls = gl.section
gl.short_line_list = { 'packer', 'NvimTree', 'Outline', 'LspTrouble' }

local colors = {
    bg = '#282a36',
    fg = '#abb2bf',
    section_bg = '#3f3e3e',
    blue = '#61afef',
    green = '#98c379',
    purple = '#c678dd',
    orange = '#e5c07b',
    red = '#e06c75',
    yellow = '#e5c07b',
    darkgrey = '#2c323d',
    middlegrey = '#8791A5',
}

-- Local helper functions
local buffer_not_empty = function()
    return not vim.fn.empty(vim.fn.expand '%:t') == 1
end

local has_width_gt = function(cols)
	return vim.fn.winwidth(0) / 2 > cols
end

local checkwidth = function()
    return vim.fn.winwidth(0) / 2 > 35 and buffer_not_empty()
end

local is_file = function()
    return vim.bo.buftype ~= 'nofile'
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value[1] == val then
            return true
        end
    end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.purple,
        [22] = colors.purple,
        [86] = colors.purple,
        [82] = colors.red,
        [115] = colors.red,
        [83] = colors.red,
    }

    local color = mode_colors[vim.fn.mode():byte()]
    if color ~= nil then
        return color
    else
        return colors.purple
    end
end

local LspCheckDiagnostics = function()
    if
        #vim.lsp.get_active_clients() > 0
        and diagnostic.get_diagnostic_error() == nil
        and diagnostic.get_diagnostic_warn() == nil
        and diagnostic.get_diagnostic_info() == nil
    then
        return ' '
    end
    return ''
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE',
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            local alias = aliases[vim.fn.mode():byte()]
            local mode
            if alias ~= nil then
                if has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = { colors.bg, colors.bg, 'bold' },
    },
}
-- gls.left[2] = {
--     Space = {
--         provider = function() return ' ' end,
--         highlight = { colors.section_bg, colors.section_bg }
--     }
-- }
gls.left[3] = {
    GitBranch = {
        provider = {
            function()
                return '   '
            end,
            'GitBranch',
	    function () return ' ' end
        },
	separator = ' ',
	separator_highlight = { colors.section_bg, colors.bg },
        condition = condition.check_git_workspace,
        highlight = { colors.middlegrey, colors.section_bg },
    },
}
gls.left[4] = {
    FilePath = {
	provider = 'FileName', 
	separator = '  ',
	condition = condition.buffer_not_empty,
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.left[8] = {
    DiagnosticsCheck = {
        provider = { LspCheckDiagnostics },
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.left[9] = {
    DiagnosticError = {
        provider = { 'DiagnosticError' },
        icon = '  ',
        highlight = { colors.red, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg}
    },
}
gls.left[11] = {
    DiagnosticWarn = {
        provider = { 'DiagnosticWarn' },
        icon = '  ',
        highlight = { colors.orange, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg}
    },
}
gls.left[13] = {
    DiagnosticInfo = {
        provider = { 'DiagnosticInfo' },
        icon = '  ',
        highlight = { colors.blue, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.section_bg, colors.bg}
    },
}

-- Right side
gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '+',
        highlight = { colors.green, colors.bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = { colors.orange, colors.bg },
    },
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = { colors.red, colors.bg },
    },
}
gls.right[7] = {
    LspStatus = {
        provider = 'GetLspClient',
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg},
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.right[8] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = { colors.blue, colors.bg },
        highlight = { colors.darkgrey, colors.blue },
    },
}
-- gls.right[9] = {
--     ScrollBar = {
--         provider = 'ScrollBar',
--         highlight = {colors.purple, colors.section_bg}
--     }
-- }

-- Short status line
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
