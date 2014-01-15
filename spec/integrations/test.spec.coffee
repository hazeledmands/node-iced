{expect} = require 'chai'
command = require './command'

describe 'iced test hooks', ->

  it 'should honor the iced_host and iced_port environment variables', (done) ->
    out = command '--ping', (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'pong'
      done()
