exports.command =
  description: 'Uploads files to a glacier archive'

if require.main is module
  glacier = require '../lib/glacier'
  fs = require 'fs'
  crypto = require 'crypto'
  nopt = require 'nopt'
  knownOpts =
    description: String
  shortHands =
    d: ['--description']
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()
  fileName = parsedOptions.argv.remain.shift()

  unless vaultName? and fileName?
    console.error """
    usage: iced archive <vault> <file> [--description=<description>]

    Uploads <file> into <vault>, optionally with a <description>.
    """
    process.exit 1

  stats = fs.statSync fileName
  console.log stats

  params = {vaultName}

  params.body = fs.readFileSync fileName

  shasum = crypto.createHash('sha256')
  shasum.update(params.body)
  params.checksum = shasum.digest 'hex'

  if parsedOptions.description?
    params.archiveDescription = parsedOptions.description

  glacier.uploadArchive params, (err, data) ->
    if err?
      console.error err
      process.exit 1
    console.log "uploaded to #{data.location}"
    console.log data
    process.exit 0
