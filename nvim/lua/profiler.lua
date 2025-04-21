local _M = {}

local utils = require("utils")

_M.setup = function()

  local perfanno = utils.safe_require("perfanno")
  local perfanno_util = utils.safe_require("perfanno.util")

  perfanno.setup {
    line_highlights = perfanno_util.make_bg_highlights(nil, "#CC3300", 10),
    vt_highlight = perfanno_util.make_fg_highlight("#CC3300")
  }

end

return _M
