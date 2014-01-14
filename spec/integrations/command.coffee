childProcess = require 'child_process'
path = require 'path'
command = "node #{path.resolve __dirname, '../../bin/iced.js'}"

module.exports = (args...) ->
  args[0] = "#{command} #{args[0]}"
  if typeof args[1] is 'object' and args[1].env?
    newEnv = process.env
    newEnv[key] = value for key, value of args[1].env
    args[1].env = newEnv
  childProcess.exec.apply childProcess, args
