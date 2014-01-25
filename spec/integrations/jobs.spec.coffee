{expect} = require 'chai'
command = require './command'

describe 'list jobs', ->

  before ->
    @server.respondWith 200,
      Marker: 'test'
      JobList: [ {
        JobId: '123abc'
        JobDescription: 'Summon the cardinals'
        Action: 'ArchiveRetrieval'
        ArchiveId: '234bcd'
        StatusCode: 'InProgress'
      }]

  it 'should list jobs in an amazon glacier account', (done) ->
    out = command 'jobs birds', (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain 'Summon the cardinals'
      expect(stdout).to.contain 'in progress'
      expect(stdout).to.contain 'archive'
      done()
