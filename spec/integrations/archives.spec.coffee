{expect} = require 'chai'
command = require './command'
path = require 'path'

describe 'upload archive', ->

  before ->
    @server.respondWith 200,
      location: 'http://aws/books/foobidoobidoo'
      checksum: '123abc'
      archiveId: 'foobidoobidoo'

  it 'should upload a file in one part', (done) ->
    out = command "archive books #{path.resolve __dirname, 'leviathan.txt'}", (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'uploaded to http://aws/books/foobidoobidoo'
      done()
