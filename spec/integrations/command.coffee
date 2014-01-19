childProcess = require 'child_process'
path = require 'path'
url = require 'url'
http = require 'http'
concat = require 'concat-stream'

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
  p = childProcess.exec shellCommand, options, callback

  # p.stdout.pipe process.stdout
  # p.stderr.pipe process.stderr
  p

before ->
  @server = http.createServer()
  @server.listen SERVER_PORT

  @server.respondWith = (status, data) =>
    @server.response = {status, data}

  @server.on 'request', (req, res) =>
    @server.request = req
    req.pipe concat (body) =>
      body = body.toString()
      @server.request.body = try
        JSON.parse body
      catch e
        body

      if @server.response?
        res.writeHead @server.response.status, 'Content-Type': 'application/json'
        res.end JSON.stringify @server.response.data

after ->
  @server.close()
