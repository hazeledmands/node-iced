{expect} = require 'chai'
command = require './command'
http = require 'http'

describe 'iced test hooks', ->

  it 'should honor the iced_host and iced_port environment variables', (done) ->
    server = http.createServer (req, res) ->
      res.writeHead 200, 'Content-Type': 'text/plain'
      res.end 'pong'
    server.listen 10001

    out = command '--ping', env: { iced_host: 'localhost', iced_port: 10001 }, (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'pong'
      server.close()
      done()

    out.stdout.pipe process.stdout
    out.stderr.pipe process.stderr
