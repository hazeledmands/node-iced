{expect} = require 'chai'
command = require './command'

describe 'request inventory', ->

  before ->
    @server.respondWith 200,
      location: 'http://aws/jobs/inventoryyy'
      jobId: 'herpderp'

  it 'should request an inventory of a vault', (done) ->
    out = command "inventory books", (err, stdout, stderr) =>
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(@server.request.method).to.equal 'POST'
      expect(@server.request.url).to.equal '/-/vaults/books/jobs'
      expect(stdout).to.contain 'Initiated inventory job \'herpderp\' at http://aws/jobs/inventoryyy'
      done()
