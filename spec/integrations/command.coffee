childProcess = require 'child_process'
path = require 'path'
http = require 'http'

shellCommandPrefix = "node #{path.resolve __dirname, '../../bin/iced.js'}"

SERVER_HOST = 'localhost'
SERVER_PORT = 10001

module.exports = command = (args..., callback) ->
  shellCommand = "#{shellCommandPrefix} #{args[0]}"
  options = if typeof args[1] is 'object' then args[1] else env: {}
  options.env[key] ?= value for key, value of process.env
  options.env.iced_host ?= SERVER_HOST
  options.env.iced_port ?= SERVER_PORT
  childProcess.exec shellCommand, options, callback

before ->
  @server = http.createServer (req, res) ->
    res.writeHead 200, 'Content-Type': 'text/plain'
    res.end 'pong'
  @server.listen SERVER_PORT

after ->
  @server.close()
