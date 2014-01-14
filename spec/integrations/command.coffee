childProcess = require 'child_process'
path = require 'path'
command = "node #{path.resolve __dirname, '../../bin/iced.js'}"

module.exports = (args...) ->
  args[0] = "#{command} #{args[0]}"
  childProcess.exec.apply childProcess, args
