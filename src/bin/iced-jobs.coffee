exports.command =
  description: 'Displays and manages running (and complete) jobs.'

if require.main is module
  glacier = require '../lib/glacier'
  columnify = require 'columnify'
  nopt = require 'nopt'
  knownOpts = {}
  shortHands = {}
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()

  unless vaultName?
    console.error """
    usage: iced jobs <vault>

    List the jobs associated with <vault>
    """
    process.exit 1

  glacier.listJobs {vaultName}, (err, data) ->

    if err?
      console.error err.message
      process.exit 1

    if data.JobList.length is 0
      console.error "No jobs found"
      process.exit 0

    console.log columnify(data.JobList)
    process.exit 0
