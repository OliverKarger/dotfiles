local utils = require('utils')

return {
  setup = function()
    utils.safe_require('formatter').setup()
  end
}
