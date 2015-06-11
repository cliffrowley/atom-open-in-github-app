switch process.platform
  when 'darwin'
    module.exports = require('./open-github-app/mac')
  when 'win32'
    module.exports = require('./open-github-app/windows')
