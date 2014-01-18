{expect} = require 'chai'
command = require './command'

describe 'list vaults', ->

  before ->
    @server.respondWith 200,
      Marker: 'test'
      VaultList: [ VaultName: 'Bird' ]

  it 'should list vaults in an amazon glacier account', (done) ->
    out = command 'vaults', (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'Bird'
      done()

describe 'create vaults', ->
  before ->
    @server.respondWith 200,
      location: 'http://myvault/foozle'

  it 'should create a new vault', (done) ->
    out = command 'vaults --create foozle', (err, stdout, stderr) =>
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'Created new vault foozle'
      expect(@server.request.url).to.contain '/vaults/foozle'
      expect(@server.request.method).to.equal 'PUT'
      done()
