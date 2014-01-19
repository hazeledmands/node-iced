exports.command =
  description: 'Displays and manages running (and complete) jobs.'

if require.main is module
  glacier = require '../lib/glacier'
  nopt = require 'nopt'
  knownOpts = {}
  shortHands = {}
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()

  unless vaultName?
    console.error "Usage:\niced jobs <vault>     list the jobs associated with <vault>"
    process.exit 1

  glacier.listJobs {vaultName}, (err, data) ->
    console.log data
    process.exit 0
