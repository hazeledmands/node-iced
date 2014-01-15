pkg = require '../package.json'

nopt = require 'nopt'
aws = require 'aws-sdk'

knownOpts =
  version: Boolean
  help: Boolean
  vaults: Boolean
shortHands =
  v: ['--version']
  h: ['--help']

args = nopt knownOpts, shortHands, process.argv

rc = require('rc') pkg.name,
  endpoint: null

if args.version
  console.log pkg.version
  process.exit 0

if args.help
  console.log pkg.description
  process.exit 0

if args.vaults
  glacier = new aws.Glacier
    endpoint: rc.endpoint
    apiVersion: '2012-06-01'
    region: 'us-west-1'
  glacier.listVaults (err, data) ->
    console.log vault.VaultName for vault in data.VaultList
    process.exit 0
