nopt = require 'nopt'

knownOpts =
  version: Boolean
  help: Boolean
shortHands =
  v: ['--version']
  h: ['--help']

args = nopt knownOpts, shortHands, process.argv

if args.version
  {version} = require '../package.json'
  console.log version
  process.exit 0

if args.help
  {description} = require '../package.json'
  console.log description
  process.exit 0
