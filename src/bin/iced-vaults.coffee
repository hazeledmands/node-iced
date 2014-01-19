exports.command =
  description: 'Manages the vaults in an Amazon Glacier account.'

if require.main is module
  glacier = require '../lib/glacier'
  columnify = require 'columnify'
  nopt = require 'nopt'
  knownOpts =
    create: String
  shortHands =
    c: ['--create']
  parsedOptions = nopt(knownOpts, shortHands, process.argv)

  if parsedOptions.create?
    glacier.createVault vaultName: parsedOptions.create, (err, data) ->
      console.log "Created new vault #{parsedOptions.create}"
  else
    glacier.listVaults (err, data) ->

      if err?
        console.error err.message
        process.exit 1

      vaults = data.VaultList.map (vault) ->
        name: vault.VaultName
        created: vault.CreationDate
        archives: vault.NumberOfArchives
        size: vault.SizeInBytes

      console.log columnify(vaults)
      process.exit 0
