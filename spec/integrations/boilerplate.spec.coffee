{expect} = require 'chai'
childProcess = require 'child_process'
path = require 'path'
command = "node #{path.resolve __dirname, '../../bin/iced.js'}"

describe 'iced boilerplate', ->
  it 'should display the current version', (done) ->
    {version} = require '../../package.json'

    childProcess.exec "#{command} --version", (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.contain version
      done()

  it 'should display help text', (done) ->

    childProcess.exec "#{command} --help", (err, stdout, stderr) ->
      expect(err).to.be.falsy
      expect(stderr).to.be.falsy
      expect(stdout).to.match /glacier/i
      done()
