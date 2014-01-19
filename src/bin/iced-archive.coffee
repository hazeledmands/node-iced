exports.command =
  description: 'Uploads files to a glacier archive'

if require.main is module
  glacier = require '../lib/glacier'
  nopt = require 'nopt'
  knownOpts = {}
  shortHands = {}
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()
  fileName = parsedOptions.argv.remain.shift()

  unless vaultName? and fileName?
    console.error "Usage:\niced jobs <vault> <file>    upload <file> into <vault>"
    process.exit 1

  # glacier.uploadArchive {vaultName}, (err, data) ->
  #   console.log data
  #   process.exit 0
