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
    usage: iced archive <vault> <file> [--description=<description>] [--partsize=<filesize>]

    Uploads <file> into <vault>.

    --description (-d) Assigns <description> to the archive
    --partsize    (-p) Divides the file into multiple <filesize> parts and uploads each separately.
                       Capable of parsing human-readable filesizes, like MB or KB. (Default value: 100MB)
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
      console.error err.message
      process.exit 1

    console.log "uploaded to #{data.location}"
    console.log data
    process.exit 0
