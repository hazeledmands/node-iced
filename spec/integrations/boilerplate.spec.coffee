{expect} = require 'chai'
command = require './command'

describe 'boilerplate arguments', ->

  it 'should display the current version', (done) ->
    {version} = require '../../package.json'

    command '--version', (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain version
      done()

  it 'should display help text', (done) ->

    command '--help', (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.match /glacier/i
      done()
