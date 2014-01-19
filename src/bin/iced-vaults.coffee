exports.command =
  description: 'Manages the vaults in an Amazon Glacier account.'

if require.main is module
  glacier = require '../lib/glacier'
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
      console.log vault.VaultName for vault in data.VaultList
      process.exit 0
