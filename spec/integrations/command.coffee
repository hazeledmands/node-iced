childProcess = require 'child_process'
path = require 'path'
url = require 'url'
http = require 'http'

shellCommandPrefix = "#{path.resolve __dirname, '../../bin/iced'}"

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
  options.env.iced_aws_access_key ?= 'abc123'
  options.env.iced_aws_access_key_id ?= 'xxxxxx'
  options.env.iced_aws_region ?= 'hades-antipodes'
  childProcess.exec shellCommand, options, callback

before ->
  @server = http.createServer (req, res) =>
    @server.handler? req, res
  @server.listen SERVER_PORT

after ->
  @server.close()
