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
    out = command "archive books #{path.resolve __dirname, 'leviathan.txt'} -d 'Leviathan, by Thomas Hobbes'", (err, stdout, stderr) =>
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(@server.request.method).to.equal 'POST'
      expect(@server.request.url).to.equal '/-/vaults/books/archives'
      expect(@server.request.headers['x-amz-content-sha256']).to.equal 'bd2f3f282408d330e398d832e232fdda94e6ae08994c9f333704ed2a6ddad12c'
      expect(@server.request.headers['x-amz-archive-description']).to.equal 'Leviathan, by Thomas Hobbes'
      expect(stdout).to.contain 'uploaded to http://aws/books/foobidoobidoo'
      done()
