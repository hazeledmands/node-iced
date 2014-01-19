exports.command =
  description: 'Requests an inventory for a vault'

if require.main is module
  glacier = require '../lib/glacier'
  nopt = require 'nopt'
  knownOpts = {}
  shortHands = {}
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()

  unless vaultName?
    console.error """
    usage: iced inventory <vault>

    Requests an inventory for <vault>, creating a new job
    """

  jobParameters =
    Type: 'inventory-retrieval'
    # SNSTopic: "Inventory for #{vaultName}"

  glacier.initiateJob {vaultName, jobParameters}, (err, data) ->

    if err?
      console.error err.message
      process.exit 1

    console.log "Initiated inventory job '#{data.jobId}' at #{data.location}"
    process.exit 0
