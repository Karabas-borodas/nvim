-- Use default configuration
require('Comment').setup()

-- or with custom configuration
require('Comment').setup {
  ignore = '^$',
  toggler = {
    line = '<leader>cc',
    block = '<leader>bc',
  },
  opleader = {
    line = '<leader>c',
    block = '<leader>b',
  },
}
