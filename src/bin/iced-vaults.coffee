pkg = require '../package.json'

exports.command =
  description: 'Manages the vaults in an Amazon Glacier account.'

if require.main is module
  aws = require 'aws-sdk'

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

  glacier.listVaults (err, data) ->
    console.log vault.VaultName for vault in data.VaultList
    process.exit 0
