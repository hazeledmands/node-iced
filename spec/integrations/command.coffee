childProcess = require 'child_process'
path = require 'path'
url = require 'url'
http = require 'http'

shellCommandPrefix = "node #{path.resolve __dirname, '../../bin/iced.js'}"

SERVER_HOSTNAME = 'localhost'
SERVER_PORT = 10001

module.exports = command = (args..., callback) ->
  shellCommand = "#{shellCommandPrefix} #{args[0]}"
  options = if typeof args[1] is 'object' then args[1] else env: {}
  options.env[key] ?= value for key, value of process.env
  options.env.iced_endpoint ?= url.format
    protocol: 'http'
    hostname: SERVER_HOSTNAME
    port: SERVER_PORT
  childProcess.exec shellCommand, options, callback

before ->
  @server = http.createServer (req, res) =>
    @server.handler? req, res
  @server.listen SERVER_PORT

after ->
  @server.close()
