exports.command =
  description: 'Manages the vaults in an Amazon Glacier account.'

if require.main is module
  nopt = require 'nopt'
  pkg = require '../package.json'
  aws = require 'aws-sdk'

  knownOpts =
    create: String
  shortHands =
    c: ['--create']
  parsedOptions = nopt(knownOpts, shortHands, process.argv)

  rc = require('rc') pkg.name,
    endpoint: null
    aws_access_key: null
    aws_access_key_id: null
    aws_region: null

  aws.config.update
    accessKeyId: rc.aws_access_key_id
    secretAccessKey: rc.aws_access_key
    region: rc.aws_region

  config =
    apiVersion: '2012-06-01'
  config.endpoint = rc.endpoint if rc.endpoint
  glacier = new aws.Glacier config

  if parsedOptions.create?
    glacier.createVault vaultName: parsedOptions.create, (err, data) ->
      console.log "Created new vault #{parsedOptions.create}"
  else
    glacier.listVaults (err, data) ->
      console.log vault.VaultName for vault in data.VaultList
      process.exit 0
