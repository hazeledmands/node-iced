pkg = require '../package.json'

nopt = require 'nopt'
request = require 'request'

knownOpts =
  version: Boolean
  help: Boolean
  ping: Boolean
shortHands =
  v: ['--version']
  h: ['--help']

args = nopt knownOpts, shortHands, process.argv

rc = require('rc') pkg.name,
  port: 8000
  host: 'aws.amazon.com'

if args.version
  console.log pkg.version
  process.exit 0

if args.help
  console.log pkg.description
  process.exit 0

if args.ping
  request "http://#{rc.host}:#{rc.port}", (err, res, body) ->
    if err
      console.error err.toString()
    else
      console.log body
    process.exit 0
